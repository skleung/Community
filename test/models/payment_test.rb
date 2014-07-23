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
#  group_id   :integer
#

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
