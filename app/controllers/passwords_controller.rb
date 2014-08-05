class PasswordsController < Devise::PasswordsController
  skip_before_filter :check_group!
  skip_before_filter :authenticate_diner_with_signup!
end