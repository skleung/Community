class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :change_current_group, :attempt_to_join_group, :join_group]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  def my_groups
    @groups = Group.all # TODO
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
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new()

    @group.name = params[:group][:name]

    if params[:password] != params[:password_confirmation]
      @group.errors.add(:base, 'Passwords do not match!')
      return render action: 'new'
    end

    @group.password = params[:password]
    @group.admin = current_diner

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
      if @group.update(name: params[:name], password: params[:password])
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
    current_user.update_attribute(:current_group_id, @group.id)
    redirect_to groups_path, notice: "Successfully switched to #{@group.name}"
  end

  def attempt_to_join_group
  end

  def join_group
    if @group.password != params[:password]
      return redirect_to attempt_join_group_path(@group), alert: "Oops that password was incorrect"
    end

    @group.diners << current_diner
    redirect_to my_groups_path, notice: "Successfully joined group #{@group.name}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

end
