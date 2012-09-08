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
    month = params[:month_no].to_i
    dependents = params[:dependents].to_i
    
    puts "Month #{month}"
    @tax = calc_tax(:single,dependents , inc, inc,month,0,0)
    puts inc
    

    respond_to do |format|
      format.js
    end

  end

end
