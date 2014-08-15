# -*- encoding: utf-8 -*-
# == Schema Information
#
# Table name: meals
#
#  id         :integer          not null, primary key
#  date       :date
#  created_at :datetime
#  updated_at :datetime
#  owner_id   :integer
#  name       :string(255)
#  chef_id    :integer
#  group_id   :integer
#


require 'rails_helper'

describe Meal do

  # TODO auto-generated
  describe '#check_group_id_of_ingredients' do
    it 'works' do
      meal = Meal.new
      result = meal.check_group_id_of_ingredients
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#has_diners?' do
    it 'works' do
      meal = Meal.new
      result = meal.has_diners?
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#has_ingredients?' do
    it 'works' do
      meal = Meal.new
      result = meal.has_ingredients?
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#cost' do
    it 'works' do
      meal = Meal.new
      result = meal.cost
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#cost_for_single_diner' do
    it 'works' do
      meal = Meal.new
      result = meal.cost_for_single_diner
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#all_ingredients_finished?' do
    it 'works' do
      meal = Meal.new
      result = meal.all_ingredients_finished?
      expect(result).not_to be_nil
    end
  end

  # TODO auto-generated
  describe '#sanity_check_finished_ingredients' do
    it 'works' do
      meal = Meal.new
      result = meal.sanity_check_finished_ingredients
      expect(result).not_to be_nil
    end
  end

end
