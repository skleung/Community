# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#  owner_id   :integer
#  name       :string(255)
#  chef_id    :integer
#  group_id   :integer
#

class Meal < ActiveRecord::Base
  belongs_to :owner, class_name: "Diner", foreign_key: "owner_id"
  belongs_to :chef, class_name: "Diner", foreign_key: "chef_id"
  belongs_to :group
  has_and_belongs_to_many :ingredients
  has_and_belongs_to_many :diners

  validates_presence_of :name, :owner, :chef, :date
  validate :has_diners?
  validate :has_ingredients?

  validate :check_group_id_of_ingredients

  accepts_nested_attributes_for :ingredients, :diners

  before_destroy :sanity_check_finished_ingredients

  def check_group_id_of_ingredients
    # TODO
    # this if statement should really be done at database level if possible
    if (ingredients.reject { |ing| ing.group_id == group_id }).any?
      errors.add(:base, "Group ID doesn't line up!")
      # nuke the relation
      ingredients.clear
    end
  end

  def has_diners?
    errors.add(:diner_ids, "A meal must have at least one diner") if !self.diners.any?
  end

  def has_ingredients?
    errors.add(:ingredient_ids, "A meal must have at least one ingredient") if !self.ingredients.any?
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

  def sanity_check_finished_ingredients
    ingredients.each do |i|
      if i.meals.count == 1
        # ensure that no ingredient can be finished without being in any meals.
        i.update_attribute(:finished, false)
      end
    end
  end
end
