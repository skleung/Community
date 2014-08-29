# -*- encoding: utf-8 -*-
# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cost       :decimal(, )
#  finished   :boolean          default(FALSE)
#  diner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#  group_id   :integer
#  servings   :integer          default(0)
#

require 'rails_helper'

describe Ingredient do

  # TODO auto-generated
  describe '#check_duplicate_names' do
    it 'works' do
      ingredient = Ingredient.new
      result = ingredient.check_duplicate_names
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#has_meals_if_finished' do
    it 'works' do
      ingredient = Ingredient.new
      result = ingredient.has_meals_if_finished
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#servings' do
    it 'works' do
      ingredient = Ingredient.new
      result = ingredient.servings
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#payment_owed_by' do
    it 'works' do
      ingredient = Ingredient.new
      id = double('id')
      result = ingredient.payment_owed_by(id)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#cost_for_number_of_diners' do
    it 'works' do
      ingredient = Ingredient.new
      number_of_diners = double('number_of_diners')
      result = ingredient.cost_for_number_of_diners(number_of_diners)
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#to_s' do
    it 'works' do
      ingredient = Ingredient.new
      result = ingredient.to_s
      expect(result).not_to be_nil
    end
  end

end
