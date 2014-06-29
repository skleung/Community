# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

diners = [
  { name: 'Kevin Casey', email: 'kacasey@berkeley.edu' },
  { name: 'Sherman Leung', email: 'swag@stanford.edu' },
  { name: 'Swag', email: 'swag@swag.com' }
]

diners.each do |diner|
  if Diner.where(email: diner[:email]).count != 0
    next
  end
  diner[:password] = '12345678'
  diner[:password_confirmation] = '12345678'
  Diner.create!(diner)
end

ingredients = [
  { name: 'Lettuce', cost: 5.49 },
  { name: 'Bread', cost: 2.21 },
  { name: 'Cheese', cost: 3.34 },
  { name: 'Turkey', cost: 4.44}
]

ingredients.each do |ingredient|
  ingredient[:diner_id] = 1
  Ingredient.where(ingredient).first_or_create!
end
