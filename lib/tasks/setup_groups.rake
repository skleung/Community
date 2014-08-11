task :setup_groups => :environment do
  Ingredient.all.each do |i|
    if not i.group_id
      i.update_attribute(:group_id, 1)
    end

    if i.finished.nil?
      i.update_attribute(:finished, false)
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