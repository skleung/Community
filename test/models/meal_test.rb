# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  chef       :string(255)
#  date       :datetime
#  created_at :datetime
#  updated_at :datetime
#  owner_id   :integer
#

require 'test_helper'

class MealTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
