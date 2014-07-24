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

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
