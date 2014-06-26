class Meal < ActiveRecord::Base
	has_and_belongs_to_many :ingredients
	has_and_belongs_to_many :diners
end
