class CreateJoinTableDinersMeals < ActiveRecord::Migration
  def change
    create_join_table :diners, :meals do |t|
      t.index [:diner_id, :meal_id]
      t.index [:meal_id, :diner_id]
    end
  end
end
