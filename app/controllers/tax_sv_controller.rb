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


  

end
