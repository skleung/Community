# -*- encoding: utf-8 -*-

require 'rails_helper'

describe ApplicationController do

  # TODO auto-generated
  describe 'GET use_access_token' do
    it 'works' do
      get :use_access_token, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET refresh_token' do
    it 'works' do
      get :refresh_token, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET exchange_token' do
    it 'works' do
      get :exchange_token, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET authenticate_diner_with_signup!' do
    it 'works' do
      get :authenticate_diner_with_signup!, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET authenticate_admin!' do
    it 'works' do
      get :authenticate_admin!, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET after_sign_in_path_for' do
    it 'works' do
      get :after_sign_in_path_for, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET check_group!' do
    it 'works' do
      get :check_group!, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET current_group' do
    it 'works' do
      get :current_group, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET current_group_ids' do
    it 'works' do
      get :current_group_ids, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
