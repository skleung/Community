# -*- encoding: utf-8 -*-

require 'rails_helper'

describe RegistrationsController do

  # TODO auto-generated
  describe 'GET configure_parameters' do
    it 'works' do
      get :configure_parameters, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'POST create' do
    it 'works' do
      post :create, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'DELETE destroy' do
    it 'works' do
      delete :destroy, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
