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
    @valid_dates = Hash.new #this is a hash of dates to an array of meal id's that are on that date
    @meals.each do |meal|
      (@valid_dates[meal.date.to_date] ||= []) << meal.id
    end
    
    @balances = []
    Diner.all.each do |d|
      if d.id != current_diner.id
        @balances << {diner_name: d.name, diner_id: d.id, balance: current_diner.balance_between(d.id)}
      end
    end
    
    @payments = Payment.where('from_id = ? OR to_id = ?', current_diner.id, current_diner.id).order(:created_at)

    @meal = Meal.new
    # @meal = Meal.where(:date === date) 
    # @meal.diners += current_diner
    #use the above array to validate whether people have signed up for a meal for that date or not
    #maybe the best way is to PATCH/PUT to the update action...
    #the tricky part will be how to catch the errors from the update method

    #or we can think about how to do a sign_up post method

    #if not, we want to display an alert asking if they'd like to make a meal on that date instead.
  end

  def signup_post
    date = DateTime.parse(params['date'])
    meals_saw = Meal.where(date: date).pluck(:id)
    meals_checked = params['meal_ids'] || [] # or nothing checked
    current_meals = current_diner.meal_ids
    meals_unchecked = meals_saw - meals_checked
    meals_to_remove = meals_unchecked & current_meals

    current_diner.meal_ids = (current_meals | meals_checked) - meals_to_remove
    current_diner.save

    redirect_to root_path, notice: "Successfully saved attendence for #{date.to_date}"
  end
  
  # POST 
  def pay
    @payment = Payment.new(pay_params)
    @payment.from_id = current_diner.id
    if @payment.save
      flash[:notice] = "Payment made."
      redirect_to root_path
    else
      redirect_to root_path, alert: @payment.errors.full_messages
    end
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

  def generate_html(meal)
    "
    <div>
      <input id='meal_diners_ids_#{meal.id}' name='meal_ids[]' type='checkbox' #{meal.diners.include?(current_diner) ? 'checked=checked' : ''} value='#{meal.id}'>
      <b>Join</b>
      <br>
      <b>Name:</b> #{meal.name}
      <br>
      <b>Chef:</b> #{meal.chef}
      <br>
      <b>Current Diners:</b> #{meal.diners.pluck(:name).join(', ')}
      <br>
      <b>Ingredients in Meal:</b> #{meal.ingredients.pluck(:name).join(', ')}
    </div>
    "
  end

  #for the join meal modal form to retrieve the attendance record for each meal id
  def get_attendance
    #build a boolean attendance record that hashes to each meal date
    date = DateTime.parse(params['date'])
    meals = Meal.where(date: date)
    meals_html = []
    meals.each do |meal|
      meals_html << generate_html(meal)
    end
    html_string = meals_html.join('')
    render :text => html_string
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def verify_yourself_or_admin!
      @meal.owner.id == current_diner.id || @meal.chef.id == current_diner.id || authenticate_admin!
    end

    def pay_params
      params.permit(:amount, :to_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      setup_ingredients_attributes
      params.require(:meal).permit(:name, :chef_id, :date, :diner_ids => [], :ingredient_ids => [], :ingredients_attributes => [:id, :finished])
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
