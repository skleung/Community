class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_diner_with_signup!
  before_action :check_group!
  protect_from_forgery with: :exception

  helper_method :current_group, :current_group_ids, :use_access_token

  def use_access_token(token)
    url = "https://api.venmo.com/v1/me?access_token=#{token}"
    JSON.parse(Net::HTTP.get(URI.parse(url)))
  end

  def authenticate_diner_with_signup!
    unless current_diner
      redirect_to welcome_path
    end
  end

  def authenticate_admin!
    redirect_to root_path, alert: "You do not have permission to access that" unless (authenticate_diner! and current_diner.role == "admin")
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  def check_group!
    redirect_to groups_path, alert: 'Oops your not in a group, join or create one' unless current_group
  end

  def current_group
    @current_group ||= current_diner.current_group
  end

  def current_group_ids
    @current_group_ids ||= current_group.diners.pluck(:id)
  end

  protected
    def after_sign_up_path_for(resource)
      signed_in_root_path(resource)
    end

    def after_update_path_for(resource)
      signed_in_root_path(resource)
    end
end
