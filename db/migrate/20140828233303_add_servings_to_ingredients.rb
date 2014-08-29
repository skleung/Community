class AddServingsToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :servings, :integer, default: 0

    Ingredient.all.each do |i|
      i.update_servings
    end
  end
end
