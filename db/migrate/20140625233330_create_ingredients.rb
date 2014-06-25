class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.decimal :cost
      t.boolean :finished

      t.timestamps
    end
  end
end
