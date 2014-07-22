class AddCurrentGroupIdToDiners < ActiveRecord::Migration
  def change
    add_column :diners, :current_group_id, :integer
  end
end
