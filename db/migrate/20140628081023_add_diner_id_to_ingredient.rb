class AddDinerIdToIngredient < ActiveRecord::Migration
  def change
    add_column :ingredients, :diner_id, :integer
  end
end
