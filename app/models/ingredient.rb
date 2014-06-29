# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cost       :decimal(, )
#  finished   :boolean
#  created_at :datetime
#  updated_at :datetime
#  diner_id   :integer
#

class Ingredient < ActiveRecord::Base
	validates :diner_id, :name, :cost, :presence => true

	has_and_belongs_to_many :meals
	belongs_to :diner
end
