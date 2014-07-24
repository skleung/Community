# == Schema Information
#
# Table name: diners_groups
#
#  diner_id :integer          not null
#  group_id :integer          not null
#

class DinersGroups < ActiveRecord::Base
  belongs_to :diner
  belongs_to :group
end
