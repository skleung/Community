class SessionsController < Devise::SessionsController
  def new
    if params["login_button"] == "true"
      @load_login_form = true
    else
      @load_login_form = false
    end
    super
  end
end