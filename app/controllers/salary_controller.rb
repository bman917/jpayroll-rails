include HolidaysHelper
include SalaryHelper

class SalaryController < ApplicationController

  def index
    @year = Time.current.year
    @month = Time.current.month
    @src = working_days_js(@month, @year)
  end

  def calc
    days_worked = JSON.parse(params[:selected_dates]).map do |o|
      Date.strptime(o, '%m/%d/%Y')
    end
    
    matched_holiday = Holiday.find_holiday_by_dates(days_worked)

    result = {
      days_worked: days_worked.length,
      holidays_worked: matched_holiday
    }

    puts result
    
    render :action => "index"
    
  end
  
end
