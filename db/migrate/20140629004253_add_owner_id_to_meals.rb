class AddOwnerIdToMeals < ActiveRecord::Migration
  def change
    add_column :meals, :owner_id, :integer
  end
end
