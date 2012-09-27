include HolidaysHelper
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

    @salary = params[:salary].to_f
    @daily_rate = @salary / 20

    @matched_holiday = Holiday.find_holiday_by_dates(selected_dates)
    @days_worked = selected_dates.length

    @holiday_pay = 0
    @matched_holiday.each { |h| @holiday_pay += @daily_rate * h.rate}

    @this_months_salary = @daily_rate * @days_worked
    @this_months_salary_w_holiday_pay = @this_months_salary + @holiday_pay

    @result = {
      days_worked: @days_worked,
      holidays_worked: @matched_holiday
    }

    puts "Daily Rate: #{@daily_rate}"
    @result[:holidays_worked].each { |h| @desc = h.description }
    puts @desc
    #render :action => "index"
    
  end
  
end
