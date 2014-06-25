require 'test_helper'

class DinersControllerTest < ActionController::TestCase
  setup do
    @diner = diners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:diners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create diner" do
    assert_difference('Diner.count') do
      post :create, diner: { name: @diner.name }
    end

    assert_redirected_to diner_path(assigns(:diner))
  end

  test "should show diner" do
    get :show, id: @diner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @diner
    assert_response :success
  end

  test "should update diner" do
    patch :update, id: @diner, diner: { name: @diner.name }
    assert_redirected_to diner_path(assigns(:diner))
  end

  test "should destroy diner" do
    assert_difference('Diner.count', -1) do
      delete :destroy, id: @diner
    end

    assert_redirected_to diners_path
  end
end
