# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_parameters
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!

  def configure_parameters
    devise_parameter_sanitizer.for(:sign_up) { |diner| diner.permit(:name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |diner| diner.permit(:name, :email, :password, :password_confirmation, :current_password) }
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

  def destroy
    resource.soft_destroy
    set_flash_message :notice, :destroyed
    sign_out(resource)
    redirect_to welcome_path
  end

end 