require 'test_helper'

class HolidaysControllerTest < ActionController::TestCase
  setup do
    @holiday = holidays(:holy_sunday)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:holidays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create holiday" do
    assert_difference('Holiday.count') do
      post :create, holiday: { date: @holiday.date, description: @holiday.description, holiday_type: @holiday.holiday_type, rate: @holiday.rate }
    end

    assert_redirected_to holiday_path(assigns(:holiday))
  end

  test "should show holiday" do
    get :show, id: @holiday
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @holiday
    assert_response :success
  end

  test "should update holiday" do
    put :update, id: @holiday, holiday: { date: @holiday.date, description: @holiday.description, holiday_type: @holiday.holiday_type, rate: @holiday.rate }
    assert_redirected_to holiday_path(assigns(:holiday))
  end

  test "should destroy holiday" do
    assert_difference('Holiday.count', -1) do
      delete :destroy, id: @holiday
    end

    assert_redirected_to holidays_path
  end
end
