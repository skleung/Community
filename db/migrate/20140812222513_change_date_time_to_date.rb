class ChangeDateTimeToDate < ActiveRecord::Migration
  def change
    change_column(:meals, :date, :date)
  end
end
