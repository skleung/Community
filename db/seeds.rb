# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#Production seeds

diners = [
  { name: 'Alexis', email: 'alexka@stanford.edu' },
  { name: 'Vivian', email: 'vhare@stanford.edu' },
  { name: 'Akaash', email: 'akaashn@stanford.edu' },
  { name: 'Midori', email: 'ng.midori@gmail.com' },
  { name: 'Brian', email: 'brixu4@stanford.edu' },
  { name: 'Jonathan', email: 'jonlu@stanford.edu' },
  { name: 'Lorena', email: 'lorenah1@stanford.edu' }
]

diners.each do |diner|
  if Diner.where(email: diner[:email]).count != 0
    next
  end
  diner[:password] = '12345678'
  diner[:password_confirmation] = '12345678'
  diner[:role] = 'user'
  Diner.create!(diner)
end

Diner.create!(name: 'Sherman', email: 'skleung@stanford.edu', password: '12345678', password_confirmation: '12345678', role: 'admin')


# if Diner.where(email: 'admin@test.com').count == 0
#   Diner.create!(name: 'admin', email: 'admin@test.com', password: '12345678', password_confirmation: '12345678', role: 'admin')
# end

ingredients = [
  { name: 'Panko box #1', cost: 2.99 },
  { name: 'Panko box #2', cost: 2.99 },
  { name: 'Pasta', cost: 1.79 },
  { name: 'Chicken Tenders', cost: 10.99},
  { name: 'Yellow Onion', cost: 1.48},
  { name: 'Cesar Salad Dressing', cost: 3.99},
  { name: 'Romaine bag #1', cost: 2.50},
  { name: 'Romaine bag #2', cost: 2.50},
  { name: 'Crutons', cost: 2.49},
  { name: 'Shredded Bag of cheese', cost: 2.79}
]

ingredients.each do |ingredient|
  ingredient[:diner_id] = 1
  Ingredient.where(ingredient).first_or_create!
end

# Ingredient.first.update_attribute(:finished, true)

# meals = [
#   { name: 'Bread and Lettuce', chef: Diner.first, owner: Diner.first, date: Date.today, ingredient_ids: [1, 2], diner_ids: [1, 2] },
#   { name: 'Bread', chef: Diner.last, owner: Diner.first, date: Date.yesterday, ingredient_ids: [2], diner_ids: [2] }
# ]

# meals.each do |meal|
#   if Meal.where(name: meal[:name]).count != 0
#     next
#   end
#   m = Meal.create!(meal)
# end

