# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  date       :datetime
#  created_at :datetime
#  updated_at :datetime
#  owner_id   :integer
#  name       :string(255)
#  chef_id    :integer
#  group_id   :integer
#

require 'test_helper'

class MealTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
