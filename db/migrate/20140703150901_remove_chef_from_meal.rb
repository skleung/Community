class RemoveChefFromMeal < ActiveRecord::Migration
  def change
    remove_column :meals, :chef, :string
  end
end
