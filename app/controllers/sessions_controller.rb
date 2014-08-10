class SessionsController < Devise::SessionsController
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!
  def new
    if params["login_button"] == "true" || params["action"] == "create"
      @load_login_form = true
    else
      @load_login_form = false
    end
    super
  end

  def create
    super
  end
end