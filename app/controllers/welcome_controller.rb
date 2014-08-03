class WelcomeController < ApplicationController
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!
  def index
  end

  def check_group
      group = Group.find_by_name(params[:group][:group])
      if group.nil?
        #TODO: direct to make new account and new group
        # nice to have - send them an email
        flash[:error] = "No group found with name, #{params[:group][:group]}. Create a new group after making an account."
        redirect_to new_diner_registration, :group_name => params[:group][:group]
      else
        email = params[:email][:email]
        existing_member = group.diners.find_by_email(email)
        if existing_member.nil?
          #add existing member to the group 
          flash[:notice] = "Please join the group #{params[:group][:group]} after making an account."
          redirect_to new_diner_registration, :group_id => group.id
        else
          flash[:notice] = "Member with email #{email} already exists"
          redirect_to new_diner_session_path
        end
      end
  end

  def about
  end

end
