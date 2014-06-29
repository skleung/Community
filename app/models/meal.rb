class Meal < ActiveRecord::Base
  belongs_to :owner, class_name: "Diner", foreign_key: "owner_id"
	has_and_belongs_to_many :ingredients
	has_and_belongs_to_many :diners

  accepts_nested_attributes_for :ingredients, :diners
end
