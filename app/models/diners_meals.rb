# == Schema Information
#
# Table name: diners_meals
#
#  diner_id :integer          not null
#  meal_id  :integer          not null
#

class DinersMeals < ActiveRecord::Base
  belongs_to :diner
  belongs_to :meal

end
