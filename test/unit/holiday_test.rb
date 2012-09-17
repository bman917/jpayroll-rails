require 'test_helper'

class HolidayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Given working days of a month, get the holidays" do
    month = 9
    year = 2012
    working_days = get_working_days(month,year)
    
    matched_holidays = Holiday.find_by_dates(working_days)

    validate = lambda do | holiday_key |
      match = nil
      fixture_holiday = holidays(holiday_key)
      matched_holidays.each do | holiday|
        match = holiday if holiday.description == fixture_holiday.description
      end
      flunk "Missing Holiday '#{fixture_holiday.description}'" unless match
    end

    validate.call(:holy_monday)
    validate.call(:holy_friday)
  end
end
