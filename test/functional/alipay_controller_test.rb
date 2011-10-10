require 'test_helper'

class AlipayControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get done" do
    get :done
    assert_response :success
  end

  test "should get pay" do
    get :pay
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

end
