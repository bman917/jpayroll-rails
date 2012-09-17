require 'test_helper'

class HolidaysHelperTest < ActionView::TestCase
  test "Test Working Days" do
    month = 9
    year = 2012

    test_date = lambda do | date, working_day |
      flunk("#{working_day} is a weekend") if working_day == Date.new(year, month, date)
    end

    working_days = get_working_days(month, year)
    working_days.each do |day|
      test_date.call(1, day)
      test_date.call(2, day)
      test_date.call(8, day)
      test_date.call(9, day)
      test_date.call(15, day)
      test_date.call(16, day)
    end
  end
end
