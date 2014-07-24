class AddGroupIdToPaymentsMealAndIngredients < ActiveRecord::Migration
  def up
    add_column :ingredients, :group_id, :integer
    add_column :payments, :group_id, :integer
    add_column :meals, :group_id, :integer

    Ingredient.all.each do |i|
      if not i.group_id
        i.update_attribute(:group_id, 1)
      end
    end

    Meal.all.each do |m|
      if not m.group_id
        m.update_attribute(:group_id, 1)
      end
    end

    Payment.all.each do |p|
      if not p.group_id
        p.update_attribute(:group_id, 1)
      end
    end
  end

  def down
    remove_column :ingredients, :group_id, :integer
    remove_column :payments, :group_id, :integer
    remove_column :meals, :group_id, :integer
  end
end
