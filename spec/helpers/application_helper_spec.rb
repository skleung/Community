# -*- encoding: utf-8 -*-

require 'rails_helper'

describe ApplicationHelper do

  # TODO auto-generated
  describe '#verify_yourself_or_admin' do
    it 'works' do
      result = verify_yourself_or_admin(id)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#verify_yourself_or_group_admin' do
    it 'works' do
      result = verify_yourself_or_group_admin(id)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#is_group_admin?' do
    it 'works' do
      result = is_group_admin?
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#is_admin?' do
    it 'works' do
      result = is_admin?
      expect(result).not_to be_nil
    end
  end

end
