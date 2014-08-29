# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cost       :decimal(, )
#  finished   :boolean          default(FALSE)
#  diner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  group_id   :integer
#  servings   :integer          default(0)
#

class Ingredient < ActiveRecord::Base
  validates_presence_of :diner_id, :name, :cost
  validates_numericality_of :cost, greater_than: 0
  belongs_to :group

  before_create :check_duplicate_names

  validate :has_meals_if_finished

  has_and_belongs_to_many :meals
  belongs_to :diner

  def check_duplicate_names
    #ensure that the name of the ingredient has an attached date if there's a duplicate name
    ingredients_with_same_name = Ingredient.where("lower(name) = ? AND group_id = ?", name.downcase, group_id)
    if (ingredients_with_same_name.length > 0)
      ingredients_with_same_name.each do |duplicate|
        name_with_date = duplicate.name + " (" + duplicate.created_at.to_date.to_s+")"
        duplicate.update_attributes(name: name_with_date)
      end
      self.name = self.name + " (newest)"
    end
  end

  def has_meals_if_finished
    errors.add(:base, "A finished ingredient must be part of some meal!") if finished && !meals.any?
  end

  # raw calculates how many 'servings' this ingredient has been split into.
  # could cache counter this better
  # this should be called whenever a meal is saved
  # and when the meal ingredients join table changes
  def update_servings
    update_attribute(:servings, DinersMeals.where(meal_id: meals).count)
  end

  def payment_owed_by(id)
    cost * DinersMeals.where(diner_id: id, meal_id: meals).count/servings
  end

  def cost_for_number_of_diners(number_of_diners)
    cost*number_of_diners/servings
  end

  def to_s
    name
  end
end
