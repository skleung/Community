class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.decimal :cost
      t.boolean :finished
      t.integer :diner_id
      t.timestamps
    end
  end
end
