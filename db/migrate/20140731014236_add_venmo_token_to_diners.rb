class AddVenmoTokenToDiners < ActiveRecord::Migration
  def change
    add_column :diners, :venmo_token, :string
    add_column :diners, :venmo_refresh_token, :string
  end
end
