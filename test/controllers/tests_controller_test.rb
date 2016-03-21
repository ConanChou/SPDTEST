require 'test_helper'

class TestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get finish" do
    get :finish
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

end
