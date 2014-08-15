# -*- encoding: utf-8 -*-

require 'rails_helper'

describe Diner do

  # TODO auto-generated
  describe '#set_default_name' do
    it 'works' do
      diner = Diner.new
      result = diner.set_default_name
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#cost' do
    it 'works' do
      diner = Diner.new
      result = diner.cost
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#request_amount_from' do
    it 'works' do
      diner = Diner.new
      another_diner_id = double('another_diner_id')
      group_id = double('group_id')
      result = diner.request_amount_from(another_diner_id, group_id)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#get_amount_owed' do
    it 'works' do
      diner = Diner.new
      another_diner_id = double('another_diner_id')
      group_id = double('group_id')
      result = diner.get_amount_owed(another_diner_id, group_id)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#balance_between' do
    it 'works' do
      diner = Diner.new
      another_diner_id = double('another_diner_id')
      group_id = double('group_id')
      result = diner.balance_between(another_diner_id, group_id)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#to_s' do
    it 'works' do
      diner = Diner.new
      result = diner.to_s
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#soft_destroy' do
    it 'works' do
      diner = Diner.new
      result = diner.soft_destroy
      expect(result).not_to be_nil
    end
  end

end
