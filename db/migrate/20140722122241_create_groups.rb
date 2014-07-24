class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :admin_id
      t.string :password_hash
      t.string :name

      t.timestamps
    end
  end
end
