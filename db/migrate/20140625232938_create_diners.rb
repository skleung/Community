class CreateDiners < ActiveRecord::Migration
  def change
    create_table :diners do |t|
      t.string :name

      t.timestamps
    end
  end
end
