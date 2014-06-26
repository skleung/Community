class CreateJoinTableIngredientsMeals < ActiveRecord::Migration
  def change
    create_join_table :ingredients, :meals do |t|
      t.index [:ingredient_id, :meal_id]
      t.index [:meal_id, :ingredient_id]
    end
  end
end
