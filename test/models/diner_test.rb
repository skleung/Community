# == Schema Information
#
# Table name: diners
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  role                   :string(255)
#  current_group_id       :integer
#  venmo_token            :string(255)
#  venmo_refresh_token    :string(255)
#

require 'test_helper'

class DinerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
