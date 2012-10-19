include TaxSvHelper
include DateLibrary

class TaxSvController < ApplicationController
  def test
	  @tax = calc_personal_tax_exemption( :single, 2)
	  @time = Time.now
  end

  def calc
    inc = params[:income].to_f
    @tax = calc_tax(:single, 0, inc, inc,0,0,0)

  end

  def calco
    inc = params[:income].to_f
    extra_income = params[:extra_income].to_f
    deductions = params[:deductions].to_f
    month = params[:month_no].to_i
    dependents = params[:dependents].to_i
    ytd_inc = params[:ytd_inc].to_f
    ytd_tax = params[:ytd_tax].to_f
    schedule = params[:schedule]

    @holidays = Holiday.find_by_month(month)

    selected_dates = JSON.parse(params[:selected_dates]).map do |o|
      Date.strptime(o, '%m/%d/%Y')
    end

    @daily_rate = inc / DateLibrary.get_working_days(month).length
    @days_worked = selected_dates.length

    @holiday_pay = 0
    @holidays.each { |h| @holiday_pay += @daily_rate * (h.rate/100) }

    puts "Daily Rate: #{@daily_rate}"
    puts "Matched Holiday #{@holidays.length}, Holiday Pay: #{@holiday_pay}"

    @this_months_salary = (@daily_rate * @days_worked) + extra_income - deductions

    @tax = calculate_tax(:single,dependents , inc, extra_income, deductions,month,ytd_tax,ytd_inc)
    #@tax = calc_tax(:single, dependents, inc, @this_months_salary, month, ytd_tax, ytd_inc)


    puts(@tax)

    respond_to do |format|
      format.js
    end

  end

end
