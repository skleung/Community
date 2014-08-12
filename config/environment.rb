# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, before environments/*.rb
app_env_vars = File.join(Rails.root, 'config', 'initializers', 'environment_variables.rb')
load(app_env_vars) if File.exists?(app_env_vars)

# Initialize the Rails application.
Community::Application.initialize!

#DateTime::DATE_FORMATS[:default]= "%m/%d/%Y %H:%M:%S"

Time::DATE_FORMATS[:default] = "%m/%d/%Y %I:%M %p"

Date::DATE_FORMATS[:default] = "%m/%d/%Y"
