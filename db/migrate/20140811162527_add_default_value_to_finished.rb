class AddDefaultValueToFinished < ActiveRecord::Migration
  def up
    change_column :ingredients, :finished, :boolean, :default => false
  end

  def down
    change_column :ingredients, :finished, :default => nil
  end
end
