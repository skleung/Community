class AddDefaultValueToFinished < ActiveRecord::Migration
  def change
    def up
      change_column :ingredients, :finished, :default => false
    end

    def down
      change_column :ingredients, :finished, :default => nil
    end
  end
end
