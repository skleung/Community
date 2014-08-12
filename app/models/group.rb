# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  admin_id      :integer
#  password_hash :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  name          :string(255)
#

require 'bcrypt'
class Group < ActiveRecord::Base
  include BCrypt

  validates :password_hash, :admin_id, :name, presence: true

  has_and_belongs_to_many :diners

  belongs_to :admin, class_name: "Diner", foreign_key: "admin_id"

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    return if new_password.blank? # don't set a blank password
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
