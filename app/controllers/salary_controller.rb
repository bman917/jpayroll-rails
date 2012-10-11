include SalaryHelper

class SalaryController < ApplicationController

  def index
    @year = Time.current.year
    @month = Time.current.month
    @default_working_days = working_days_js(@month, @year)
  end

  def calc
    selected_dates = JSON.parse(params[:selected_dates]).map do |o|
      Date.strptime(o, '%m/%d/%Y')
    end

    month = selected_dates.first.month
    year = selected_dates.first.year

    @salary = params[:salary].to_f
    @daily_rate = @salary / get_working_days(month,year).length

    @matched_holiday = Holiday.find_holiday_by_dates(selected_dates)
    @days_worked = selected_dates.length

    @holiday_pay = 0
    @matched_holiday.each { |h| @holiday_pay += @daily_rate * (h.rate/100) }

    puts "Daily Rate: #{@daily_rate}"
    puts "Matched Holiday #{@matched_holiday.length}, Holiday Pay: #{@holiday_pay}"

    @this_months_salary = @daily_rate * @days_worked
    @this_months_salary_w_holiday_pay = @this_months_salary + @holiday_pay

    @matched_holiday.each do |h|
      @desc = h.description
      puts "Desc: #{@desc}"
    end
    
  end
  
end
