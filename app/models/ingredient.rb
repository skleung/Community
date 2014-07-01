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

  def pieces
    # detemines how many 'servings' this ingredient has been split into.
    DinersMeals.where(meal_id: meals).count
  end

  def cost_for_number_of_diners(number_of_diners)
    cost*number_of_diners/pieces
  end

  def to_s
    name
  end
end
