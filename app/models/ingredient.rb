class Ingredient < ActiveRecord::Base
	has_and_belongs_to_many :meals
	belongs_to :diner
end
