class AddUniquenessIndexOnJoinTables < ActiveRecord::Migration
  def change
    remove_index :diners_meals, [ :diner_id, :meal_id ]
    remove_index :ingredients_meals, [ :ingredient_id, :meal_id ]
    remove_index :diners_groups, [ :diner_id, :group_id ]
    add_index :diners_meals, [ :diner_id, :meal_id ], :unique => true
    add_index :ingredients_meals, [ :ingredient_id, :meal_id ], :unique => true
    add_index :diners_groups, [ :diner_id, :group_id ], :unique => true
  end
end
