class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :change_current_group, :attempt_to_join_group, :join_group]
  before_filter :verify_yourself_or_admin!, only: [:edit, :update, :destroy]

  skip_before_filter :check_group!

  def verify_yourself_or_admin!
    @group.id == current_diner.id || authenticate_admin!
  end

  # GET /groups
  # GET /groups.json
  def index
    if session[:group_id]
      redirect_to attempt_join_group_path(Group.find_by_id(session[:group_id]))
    elsif session[:group_name]
      redirect_to new_group_path
    end
    @groups = Group.where.not(id: current_diner.groups)
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
    session[:group_name] = nil #ensures this redirect only happens once
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

    if params[:password] != params[:password_confirmation]
      @group.errors.add(:base, 'Passwords do not match!')
      return render action: 'new'
    end

    @group.password = params[:password]
    @group.admin = current_diner
    @group.diner_ids = params[:group][:diner_ids] << current_diner.id

    respond_to do |format|
      if @group.save
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
    if params[:password] != params[:password_confirmation]
      @group.errors.add(:base, 'Passwords do not match!')
      return render action: 'edit'
    end
    respond_to do |format|
      if @group.update(name: params[:group][:name], password: params[:group][:password])
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
      format.html { redirect_to groups_url }
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
    session[:group_id] = nil #ensures that redirect happens just once (so they can click cancel)
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
