class MultiDatePickerController < ApplicationController
  def all
    src = ""

    year = Time.current.year
    month = Time.current.month
    
    working_days = []
    (1..Time.days_in_month(month, year)).each do |i|
      d = Date.new(year, month, i)
      working_days << d unless d.saturday? || d.sunday?
    end

    working_days.each do |working_day|
      d = working_day.day
      src += "date.setDate(#{d}),"
    end

    src = src[0..-2]
    @default_working_days = src

  end

  def fist_half
  end

  def seconf_half
  end

  def clear_all
  end
end
