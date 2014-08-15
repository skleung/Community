# -*- encoding: utf-8 -*-

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
