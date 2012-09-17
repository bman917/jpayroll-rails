module HolidaysHelper
  def get_working_days(month, year)
    working_days = []
    (1..Time.days_in_month(month, year)).each do |i|
      d = Date.new(year, month, i)
      working_days << d unless d.saturday? || d.sunday?
    end
    return working_days
  end
end
