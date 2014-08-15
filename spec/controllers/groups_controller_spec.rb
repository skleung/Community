# -*- encoding: utf-8 -*-

require 'rails_helper'

describe GroupsController do

  # TODO auto-generated
  describe 'GET verify_yourself_or_admin!' do
    it 'works' do
      get :verify_yourself_or_admin!, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET index' do
    it 'works' do
      get :index, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET my_groups' do
    it 'works' do
      get :my_groups, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET show' do
    it 'works' do
      get :show, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET new' do
    it 'works' do
      get :new, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET edit' do
    it 'works' do
      get :edit, {}, {}
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
  describe 'PUT update' do
    it 'works' do
      put :update, {}, {}
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

  # TODO auto-generated
  describe 'GET change_current_group' do
    it 'works' do
      get :change_current_group, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET attempt_to_join_group' do
    it 'works' do
      get :attempt_to_join_group, {}, {}
      expect(response.status).to eq(200)
    end
  end

  # TODO auto-generated
  describe 'GET join_group' do
    it 'works' do
      get :join_group, {}, {}
      expect(response.status).to eq(200)
    end
  end

end
