class AddGroupIdToPaymentsMealAndIngredients < ActiveRecord::Migration
  def up
    add_column :ingredients, :group_id, :integer
    add_column :payments, :group_id, :integer
    add_column :meals, :group_id, :integer
  end

  def down
    remove_column :ingredients, :group_id, :integer
    remove_column :payments, :group_id, :integer
    remove_column :meals, :group_id, :integer
  end
end
