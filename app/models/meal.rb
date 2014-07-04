# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  date       :datetime
#  created_at :datetime
#  updated_at :datetime
#  owner_id   :integer
#  name       :string(255)
#  chef_id    :integer
#

class Meal < ActiveRecord::Base
  belongs_to :owner, class_name: "Diner", foreign_key: "owner_id"
  belongs_to :chef, class_name: "Diner", foreign_key: "chef_id"
	has_and_belongs_to_many :ingredients
	has_and_belongs_to_many :diners

  validate :name, :owner, :chef, :date, presence: true
  validate :has_diners?
  validate :has_ingredients?
  validate :date, uniqueness: true

  accepts_nested_attributes_for :ingredients, :diners

  def ingredients_attributes=(attributes)
    attributes.each do |hsh|
      ingredient = Ingredient.find(hsh["id"])
      ingredient.update_attributes(hsh)
    end
  end

  def has_diners?
    errors.add(:base, "A meal must have at least one diner") if !self.diners.any?
  end

  def has_ingredients?
    errors.add(:base, "A meal must have at least one ingredient") if !self.ingredients.any?
  end 

  def cost
    ingredients.sum{|ing| ing.cost_for_number_of_diners(diners.count) }
  end

  def cost_for_single_diner
    all_ingredients_finished? ? ingredients.sum{|ing| ing.cost_for_number_of_diners(1) } : 0
  end

  def all_ingredients_finished?
    !ingredients.where(finished: false).any?
  end
end
