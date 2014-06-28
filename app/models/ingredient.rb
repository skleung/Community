class Ingredient < ActiveRecord::Base
	validates :diner_id, :name, :cost, :presence => true

	has_and_belongs_to_many :meals
	belongs_to :diner
end
