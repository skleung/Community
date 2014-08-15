# -*- encoding: utf-8 -*-
# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  admin_id      :integer
#  password_hash :string(255)
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#


require 'rails_helper'

describe Group do

  # TODO auto-generated
  describe '#password' do
    it 'works' do
      group = Group.new
      result = group.password
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#password=' do
    it 'works' do
      group = Group.new
      new_password = double('new_password')
      result = group.password=(new_password)
      expect(result).not_to be_nil
    end
  end

end
