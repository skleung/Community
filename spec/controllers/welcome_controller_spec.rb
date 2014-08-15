# -*- encoding: utf-8 -*-

require 'rails_helper'

describe WelcomeController do

  # TODO auto-generated
  describe 'GET index' do
    it 'works' do
      get :index, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET check_group' do
    it 'works' do
      get :check_group, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
