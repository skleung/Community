# == Schema Information
#
# Table name: ingredients_meals
#
#  ingredient_id :integer          not null
#  meal_id       :integer          not null
#

class IngredientsMeals < ActiveRecord::Base
  belongs_to :ingredient
  belongs_to :meal

end
