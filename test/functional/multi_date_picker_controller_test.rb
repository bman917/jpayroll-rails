require 'test_helper'

class MultiDatePickerControllerTest < ActionController::TestCase
  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get fist_half" do
    get :fist_half
    assert_response :success
  end

  test "should get seconf_half" do
    get :seconf_half
    assert_response :success
  end

end
