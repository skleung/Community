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
  validates :diner_id, :name, :cost, presence: true

  before_create :check_duplicate_names
    

  has_and_belongs_to_many :meals
  belongs_to :diner

  def check_duplicate_names
    #ensure that the name of the ingredient has an attached date if there's a duplicate name
    ingredients_with_same_name = Ingredient.select{|ingredient| ingredient.name.downcase.include? self.name.downcase}
    if (ingredients_with_same_name.length > 0)
      ingredients_with_same_name.each do |duplicate|
        name_with_date = self.name + " (" + duplicate.created_at.to_date.to_s+")"
        duplicate.update_attributes(name: name_with_date)
      end
      self.name = self.name + " (newly bought)"
    end
  end 

  def servings
    # detemines how many 'servings' this ingredient has been split into.
    DinersMeals.where(meal_id: meals).count
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
