include HolidaysHelper

module SalaryHelper


  def working_days_js(month, year)
    src = ""
    working_days = get_working_days(@month, @year)
    working_days.each do |working_day|
      d = working_day.day
      src += "date.setDate(#{d}),"
    end

    src = src[0..-2]
  end
end
