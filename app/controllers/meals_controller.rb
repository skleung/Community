class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_filter :verify_yourself_or_admin!, only: [:edit, :update, :destroy]

  # GET /meals
  # GET /meals.json
  def index
    index_setup
    @meal = Meal.new
    @ingredient = Ingredient.new
  end

  def index_setup
    @defaultDinerID = current_diner.id
    @meals = Meal.where(group: current_group).includes(:chef, :owner)
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
    @meal.date = Date.today
    @defaultDinerID = current_diner.id
  end

  # GET /meals/1/edit
  def edit
    @edit = true
    @defaultDinerID = @meal.owner.id
    @ingredient = Ingredient.new
  end

  # POST /meals
  # POST /meals.json
  def create
    @meal = Meal.new(meal_params)
    @meal.owner = current_diner #owner should always be the guy that's logged in
    @meal.group = current_group

    respond_to do |format|
      if @meal.save
        update_ingredients_after_save
        flash[:notice] = 'Meal was successfully created.'
        format.js { render action: 'meal_success', status: :created, location: @meal }
      else
        format.js { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def signup
    signup_setup
    @meal = Meal.new
    @ingredient = Ingredient.new
  end

  def signup_setup
    @meals = Meal.where(group: current_group)
    @valid_dates = @meals.pluck(:date) # array of dates
    
    @balances = []
    Diner.where(id: current_group_ids).where.not(id: current_diner.id).each do |d|
      @balances << {diner_name: d.name, diner_id: d.id, balance: current_diner.balance_between(d.id, current_group.id), venmo_token: d.venmo_token}
    end

    @payments = Payment.where(group: current_group).where('from_id = ? OR to_id = ?', current_diner.id, current_diner.id).order(:created_at).includes(:from, :to)
  end

  def signup_post
    date = Date.strptime(params['date'],"%m/%d/%Y")
    meals_saw = Meal.where(date: date, group: current_group).pluck(:id)
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
    @payment.group = current_group
    unless current_group_ids.include? @payment.to_id
      return redirect_to, alert: "Can't make payments across groups!"
    end
    if @payment.save
      redirect_to root_path, notice: "Payment made."
    else
      redirect_to root_path, alert: @payment.errors.full_messages
    end
  end

  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    respond_to do |format|
      if @meal.update(meal_params)
        update_ingredients_after_save
        flash[:notice] = 'Meal was successfully updated.'
        format.js { render action: 'meal_updated_success', status: :updated, location: @meal }
      else
        format.js { render json: @meal.errors, status: :unprocessable_entity }
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
    date = Date.strptime(params['date'],"%m/%d/%Y")
    meals = Meal.where(date: date, group: current_group)
    meals_html = []
    meals.each do |meal|
      meals_html << generate_html(meal)
    end
    html_string = meals_html.join('')
    render :text => html_string
  end

  def update_ingredients_after_save
    ingredients_saw = Ingredient.where(group: current_group, finished: false)
    if @meal
      ingredients_saw |= @meal.ingredients
    end

    ingredients_saw_ids = ingredients_saw.collect { |i| i.id.to_s } # need them in string since params passes them in as string

    #check off the finished ingredients
    finished_ids = params[:finished_ingredient_ids] & params[:meal][:ingredient_ids]
    finished_ids.each do |id|
      i = Ingredient.find_by_id(id)
      if i && i.group == current_group
        i.finished = true
        i.save
      end
    end

    #uncheck unfinished ingredients
    unfinished_ids = ingredients_saw_ids - finished_ids
    unfinished_ids.each do |id|
      i = Ingredient.find_by_id(id)
      if i && i.group == current_group
        i.finished = false
        i.save
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.where(group: current_group).find(params[:id])
    end

    def verify_yourself_or_admin!
      # you can modify meals if you are the owner, chef, admin of the group, or global admin
      @meal.owner == current_diner || @meal.chef == current_diner || @meal.group.admin == current_diner || authenticate_admin!
    end

    def pay_params
      params.permit(:amount, :to_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      setup_ingredients_attributes
      setup_date
      params.require(:meal).permit(:name, :chef_id, :date, :group_id, :diner_ids => [], :ingredient_ids => [])
    end

    # ingredient_attributes needs to be an array of hashes
    def setup_ingredients_attributes
      params[:meal][:ingredient_ids] = [] unless params[:meal][:ingredient_ids] # set ids to empty if no ingredients selected
      params[:meal][:ingredient_ids].delete("") # purge empty string if chosen creates
      params[:meal][:ingredient_ids].map!(&:to_i) # easier to work with all ints
    end

    def setup_date
      return if params[:meal][:date].is_a? Date
      return if params[:meal][:date].empty?
      params[:meal][:date] = Date.strptime(params[:meal][:date],"%m/%d/%Y")
    end
end
