include TaxSvHelper

class TaxSvController < ApplicationController
  def show
	@tax = calc_personal_tax_exemption( :single, 2)
	@time = Time.now

  end
end
