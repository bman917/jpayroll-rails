include TaxSvHelper

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
    deductions = params[:deductions].to_f
    month = params[:month_no].to_i
    dependents = params[:dependents].to_i
    ytd_inc = params[:ytd_inc].to_f
    ytd_tax = params[:ytd_tax].to_f
    
    puts "Month #{month}"
    puts "ytd_inc #{ytd_inc}"
    puts inc
    
    @tax = calc_tax(:single,dependents , inc, (inc-deductions),month,ytd_tax,ytd_inc)
    
    puts(@tax)

    respond_to do |format|
      format.js
    end

  end

end
