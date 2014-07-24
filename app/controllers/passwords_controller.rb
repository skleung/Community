class PasswordsController < Devise::PasswordsController
  skip_before_filter :check_group!
end