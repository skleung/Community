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
  { name: 'Kevin', email: 'kacasey@berkeley.edu'},
  { name: 'Kev', email: 'swag@swag.com'},
  { name: 'So-def', email: 'a@b.com'},
  { name: 'Mike', email: 'a@a.com'}
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

first = Group.create(admin: Diner.first, password: '12345678', name: 'first group')
second = Group.create(admin: Diner.last, password: '12345678', name: 'second group')

first.password = '12345678'
first.diner_ids = [1, 2, 3]
first.save
second.password = '12345678'
second.diner_ids = [1, 4, 5]
second.save

# if Diner.where(email: 'admin@test.com').count == 0
#   Diner.create!(name: 'admin', email: 'admin@test.com', password: '12345678', password_confirmation: '12345678', role: 'admin')
# end

ingredients = [
  { name: 'Bread', cost: 3.0},
  { name: 'Lettuce', cost: 5.0},
  { name: 'Panko box #1', cost: 2.99 },
  { name: 'Panko box #2', cost: 2.99 },
  { name: 'Pasta', cost: 1.79 },
  { name: 'Chicken Tenders', cost: 10.99},
  { name: 'Yellow Onion', cost: 1.48},
  { name: 'Cesar Salad Dressing', cost: 3.99},
  { name: 'Romaine bag #1', cost: 2.50},
  { name: 'Romaine bag #2', cost: 2.50},
  { name: 'Crutons', cost: 2.49},
  { name: 'Shredded Bag of cheese', cost: 2.79},

]

ingredients.each do |ingredient|
  ingredient[:diner_id] = 1
  ingredient[:group_id] = 1
  Ingredient.where(ingredient).first_or_create!
end

Ingredient.first.update_attribute(:finished, true)

meals = [
  { name: 'Bread and Lettuce', chef: Diner.first, owner: Diner.first, date: Date.today, ingredient_ids: [1, 2], diner_ids: [1, 2] },
  { name: 'Lettuce', chef: Diner.last, owner: Diner.first, date: Date.yesterday, ingredient_ids: [2], diner_ids: [2] }
]

meals.each do |meal|
  if Meal.where(name: meal[:name]).count != 0
    next
  end
  meal[:group_id] = 1
  m = Meal.create!(meal)
end

Ingredient.where(group_id: 2, name: 'test_other_group', cost: 0.1, diner_id: 1).first_or_create!

Payment.create(from_id: 1, to_id: 2, amount: 100, group: Group.first)
Payment.create(from_id: 2, to_id: 3, amount: 200, group: Group.first)
Payment.create(from_id: 3, to_id: 2, amount: 300, group: Group.first)
