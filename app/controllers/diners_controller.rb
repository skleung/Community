class DinersController < ApplicationController
  before_action :set_diner, only: [:show, :edit, :update, :destroy]

  # GET /diners
  # GET /diners.json
  def index
    @diners = Diner.all
  end

  # GET /diners/1
  # GET /diners/1.json
  def show
  end

  # GET /diners/new
  def new
    @diner = Diner.new
  end

  # GET /diners/1/edit
  def edit
  end

  # POST /diners
  # POST /diners.json
  def create
    @diner = Diner.new(diner_params)

    respond_to do |format|
      if @diner.save
        format.html { redirect_to @diner, notice: 'Diner was successfully created.' }
        format.json { render action: 'show', status: :created, location: @diner }
      else
        format.html { render action: 'new' }
        format.json { render json: @diner.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diners/1
  # PATCH/PUT /diners/1.json
  def update
    respond_to do |format|
      if @diner.update(diner_params)
        format.html { redirect_to @diner, notice: 'Diner was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @diner.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diners/1
  # DELETE /diners/1.json
  def destroy
    @diner.destroy
    respond_to do |format|
      format.html { redirect_to diners_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diner
      @diner = Diner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diner_params
      params.require(:diner).permit(:name)
    end
end
