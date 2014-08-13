class WelcomeController < ApplicationController
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!
  def index
  end

  def check_group
      diner = Diner.find_by_email(params[:email][:email])
      session[:email] = params[:email][:email]
      if diner.nil?
        redirect_to new_diner_registration_path
      else
        flash[:notice] = "Welcome back! Sign in to access your dashboard."  
        redirect_to new_diner_session_path
      end
  end

end
