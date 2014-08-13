class WelcomeController < ApplicationController
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!
  def index
  end

  def check_group
      group = Group.find_by_name(params[:group][:group])
      diner = Diner.find_by_email(params[:email][:email])
      session[:email] = params[:email][:email]
      if diner.nil?
        if group.nil?
          # TODO: nice to have - send them an email
          session[:group_name] = params[:group][:group]
          flash[:notice] = "No group found with name, #{params[:group][:group]}. Create the group after making an account."
          redirect_to new_diner_registration_path
        else
          # add existing member to the group
          session[:group_id] = group.id
          flash[:notice] = "Please join the group #{params[:group][:group]} after making an account."
          redirect_to new_diner_registration_path
        end
      else
        session[:group_id] = nil;
        session[:group_name] = nil;
        flash[:notice] = "Welcome back! Sign in to access your dashboard."  
        redirect_to new_diner_session_path
      end
  end

end
