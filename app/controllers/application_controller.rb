require 'net/http'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_diner_with_signup!
  before_action :check_group!
  protect_from_forgery with: :exception

  helper_method :current_group, :current_group_ids, :use_access_token

  def use_access_token(token, diner_id)
    result_hash = exchange_token(token)
    if result_hash['error']
      if result_hash['error']['code'] == 256 # access token expired
        refresh_hash = refresh_token(diner_id)
        current_diner.update_attributes(venmo_token: refresh_hash["access_token"], venmo_refresh_token: refresh_hash["refresh_token"])
        result_hash = exchange_token(current_diner.venmo_token)
      else
        flash[:alert] = "Something went wrong with Venmo #{result_hash['error']['message']}"
      end
    end
    result_hash
  end

  def refresh_token(diner_id)
    url = "https://api.venmo.com/v1/oauth/access_token"
    params = {
      "client_id" => ENV['VENMO_CLIENT_ID'],
      "client_secret" => ENV['VENMO_CLIENT_SECRET'],
      "refresh_token" => Diner.find_by_id(diner_id).venmo_refresh_token
    }
    JSON.parse(Net::HTTP.post_form(URI.parse(url), params).body)
  end

  def exchange_token(token)
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
    return if current_group
    if session[:group_name]
      group = Group.find_by_name(session[:group_name])
      unless group.nil?
        return redirect_to attempt_join_group_path(group.id), notice: "Found group #{session[:group_name]}, please proceed to join the group"
      end
      return redirect_to new_group_path, notice: "Create your group"
    end
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
