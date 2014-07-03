class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_filter :verify_yourself_or_admin!, only: [:edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.all
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
    @diners = @meal.diners
    @ingredients = @meal.ingredients
  end

  # GET /meals/new
  def new
    @meal = Meal.new
    @defaultDinerID = current_diner.id
  end

  # GET /meals/1/edit
  def edit
    @defaultDinerID = @meal.owner.id
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)
    @meal.owner = current_diner #owner should always be the guy that's logged in

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @meal }
      else
        format.html { render action: 'new' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def signup
    @meals = Meal.all
    @valid_dates_for_meals = @meals.map{|meal| meal.date}
    
    # @meal = Meal.where(:date === date) 
    # @meal.diners += current_diner
    #use the above array to validate whether people have signed up for a meal for that date or not
    #maybe the best way is to PATCH/PUT to the update action...
    #the tricky part will be how to catch the errors from the update method

    #or we can think about how to do a sign_up post method

    #if not, we want to display an alert asking if they'd like to make a meal on that date instead.
  end

  def signup_post
  end


  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def verify_yourself_or_admin!
      @meal.owner.id == current_diner.id || authenticate_admin!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      setup_ingredients_attributes
      params.require(:meal).permit(:name, :chef, :date, :diner_ids => [], :ingredient_ids => [], :ingredients_attributes => [:id, :finished])
    end

    # ingredient_attributes needs to be an array of hashes
    def setup_ingredients_attributes
      if params[:meal][:ingredients_attributes]
        params[:meal][:ingredients_attributes].map! do |str|
          str.kind_of?(String) ? eval(str) : str
        end
      end

      params[:meal][:ingredient_ids] = [] unless params[:meal][:ingredient_ids] # set ids to empty if no ingredients selected
    end
end
