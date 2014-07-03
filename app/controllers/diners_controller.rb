class DinersController < ApplicationController
  before_action :set_diner, only: [:show, :edit, :update, :destroy]
  before_filter :verify_yourself_or_admin!, only: [:edit, :update, :destroy]

  # GET /diners
  # GET /diners.json
  def index
    @diners = Diner.all
  end

  # GET /diners/1
  # GET /diners/1.json
  def show
  end

  # GET /diners/1/edit
  def edit
    if (current_diner.id.to_s != params[:id])
      redirect_to diners_path, flash: {error: "Error. You cannot change another diner's account." }
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
    #add admin check here!
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

    def verify_yourself_or_admin!
      @diner.id == current_diner.id || authenticate_admin!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diner_params
      params.require(:diner).permit(:name)
    end
end
