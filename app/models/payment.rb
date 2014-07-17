# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  from_id    :integer
#  to_id      :integer
#  amount     :decimal(, )
#  created_at :datetime
#  updated_at :datetime
#

class Payment < ActiveRecord::Base
  belongs_to :from, class_name: "Diner", foreign_key: "from_id"
  belongs_to :to, class_name: "Diner", foreign_key: "to_id"

  validate :from_id, :to_id, :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }

end