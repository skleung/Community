class DinersGroups < ActiveRecord::Migration
  def change
    create_join_table :diners, :groups do |t|
      t.index [:diner_id, :group_id]
      t.index [:group_id, :diner_id]
    end
  end
end
