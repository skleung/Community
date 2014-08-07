class WelcomeController < ApplicationController
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!
  def index
  end

  def check_group
      group = Group.find_by_name(params[:group][:group])
      diner = Diner.find_by_email(params[:email][:email])
      if diner.nil?
        if group.nil?
          #TODO: direct to make new account and new group
          # nice to have - send them an email
          session[:email] = params[:email][:email]
          session[:group_name] = params[:group][:group]
          flash[:error] = "No group found with name, #{params[:group][:group]}. Create a new group after making an account."
          redirect_to new_diner_registration_path, :group_name => params[:group][:group]
        else
          #add existing member to the group 
          session[:group_id] = group.id
          session[:email] = params[:email][:email]
          flash[:notice] = "Please join the group #{params[:group][:group]} after making an account."
          redirect_to new_diner_registration_path(:group_id => group.id)
        end
      else
        session[:group_id] = nil;
        session[:group_name] = nil;
        flash[:notice] = "Welcome back! Sign in to access your dashboard."  
        redirect_to new_diner_session_path
      end
  end

  def about
  end

end
