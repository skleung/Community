class AddChefIdToMeal < ActiveRecord::Migration
  def change
    add_column :meals, :chef_id, :integer
  end
end
