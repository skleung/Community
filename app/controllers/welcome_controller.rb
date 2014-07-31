class WelcomeController < ApplicationController
  def index
  end

  def check_group
      group = Group.find_by_name(params[:group][:group])
      if group.nil?
        #TODO: direct to make new account
        # nice to have - send them an email
      else
        email = params[:email][:email]
        existing_member = group.diners.find_by_email(email)
        if existing_member.nil?
          #add existing member to the group 
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
