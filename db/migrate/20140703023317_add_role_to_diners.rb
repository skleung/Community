class AddRoleToDiners < ActiveRecord::Migration
  def change
    add_column :diners, :role, :string
  end
end
