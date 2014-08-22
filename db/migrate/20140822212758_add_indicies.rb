class AddIndicies < ActiveRecord::Migration
  def change
    add_index :payments, :from_id
    add_index :payments, :to_id
    add_index :payments, :group_id
    add_index :diners, :current_group_id
    add_index :groups, :admin_id
    add_index :ingredients, :group_id
    add_index :ingredients, :diner_id
    add_index :meals, :owner_id
    add_index :meals, :chef_id
    add_index :meals, :group_id
  end
end
