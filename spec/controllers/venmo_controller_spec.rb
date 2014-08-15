# -*- encoding: utf-8 -*-

require 'rails_helper'

describe VenmoController do

  # TODO auto-generated
  describe 'GET pay' do
    it 'works' do
      get :pay, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET link' do
    it 'works' do
      get :link, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET signup' do
    it 'works' do
      get :signup, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET oauth' do
    it 'works' do
      get :oauth, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET exchange_code' do
    it 'works' do
      get :exchange_code, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET make_venmo_payment' do
    it 'works' do
      get :make_venmo_payment, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET unlink' do
    it 'works' do
      get :unlink, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
