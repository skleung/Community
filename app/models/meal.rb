# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  chef       :string(255)
#  date       :datetime
#  created_at :datetime
#  updated_at :datetime
#  owner_id   :integer
#

class Meal < ActiveRecord::Base
  belongs_to :owner, class_name: "Diner", foreign_key: "owner_id"
	has_and_belongs_to_many :ingredients
	has_and_belongs_to_many :diners

  validate :has_ingredients?

  accepts_nested_attributes_for :ingredients, :diners

  def ingredients_attributes=(attributes)
    attributes.each do |hsh|
      ingredient = Ingredient.find(hsh["id"])
      ingredient.update_attributes(hsh)
    end
  end

  def has_ingredients?
    errors.add(:base, "A meal must have at least one ingredient") if !self.ingredients.any?
  end 

  def cost
    return 2.0
  end
end
