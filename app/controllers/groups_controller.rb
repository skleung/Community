class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :change_current_group, :attempt_to_join_group, :join_group]
  before_filter :verify_yourself_or_admin!, only: [:edit, :update, :destroy]

  skip_before_filter :check_group!

  def verify_yourself_or_admin!
    @group.admin.id == current_diner.id || authenticate_admin!
  end

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.where.not(id: current_diner.groups).includes(:admin)
  end

  def my_groups
    @groups = current_diner.groups.includes(:admin)
    @only_my_groups = true
    render :index
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @diners = @group.diners
  end

  # GET /groups/new
  def new
    @group_name = session[:group_name]
    session[:group_name] = nil # served its purpose, clear it.
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new
    @group.name = params[:group][:name]
    if params[:password][:password] != params[:password_confirmation][:password_confirmation]
      @group.errors.add(:base, 'Passwords do not match!')
      return render action: 'new'
    end

    @group.password = params[:password][:password]
    @group.admin = current_diner
    @group.diner_ids = params[:group][:diner_ids] << current_diner.id


    respond_to do |format|
      if @group.save
        current_diner.update_attribute(:current_group_id, @group.id)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    if @group.password != params[:current_password][:current_password]
      @group.errors.add(:base, "Current password was incorrect")
      return render action: 'edit'
    end
    if params[:password][:password] != params[:password_confirmation][:password_confirmation]
      @group.errors.add(:base, 'Passwords do not match!')
      return render action: 'edit'
    end
    @group.diner_ids = params[:group][:diner_ids] << current_diner.id
    respond_to do |format|
      if @group.update(name: params[:group][:name], password: params[:password][:password])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to my_groups_url }
      format.json { head :no_content }
    end
  end

  def change_current_group
    unless current_diner.groups.include? @group
      return redirect_to my_groups_path, error: "You don't appear to be in #{@group.name}"
    end
    current_diner.update_attribute(:current_group_id, @group.id)
    redirect_to my_groups_path, notice: "Successfully switched to #{@group.name}"
  end

  def attempt_to_join_group
  end

  def join_group
    if @group.password != params[:password]
      return redirect_to attempt_join_group_path(@group), alert: "Oops that password was incorrect"
    end

    @group.diners << current_diner
    current_diner.update_attribute(:current_group_id, @group.id)
    redirect_to my_groups_path, notice: "Successfully joined group #{@group.name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

end
