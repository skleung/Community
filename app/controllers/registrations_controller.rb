# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_parameters 

  def configure_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |diner| diner.permit(:name, :email, :password, :password_confirmation, :remember_me) }
  end

  def new
    super
  end

  def create
	super
  end

  def update
    super
  end

end 