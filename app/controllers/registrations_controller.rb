# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_parameters
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!

  def configure_parameters
    devise_parameter_sanitizer.for(:sign_up) { |diner| diner.permit(:name, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |diner| diner.permit(:name, :email, :password, :password_confirmation, :current_password) }
  end

  def create
    group = Group.find_by_name(params[:group][:group])
    session[:group_name] = params[:group][:group]
    unless group.nil?
      session[:group_id] = group.id
    end
    super
    if current_diner
      current_diner.update_attributes(venmo_token: session['venmo_access_token'], venmo_refresh_token: session['venmo_refresh_token'])
      session['venmo_access_token'] = nil
      session['venmo_refresh_token'] = nil
    end
  end

  def destroy
    resource.soft_destroy
    set_flash_message :notice, :destroyed
    sign_out(resource)
    redirect_to welcome_path
  end

end 