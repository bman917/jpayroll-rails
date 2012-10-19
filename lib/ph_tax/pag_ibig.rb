module PhTax::PagIbig

  def self.calc(monthly_income, year=Time.now.year)
    formula = get_pag_ibig_formula(year)
    formula.call(monthly_income)
  end

  def self.get_pag_ibig_formula(year)
    # We only have 1 version for now
    PAGIBIG_2012
  end

  PAGIBIG_2012 = lambda do |monthlyIncome|
    if monthlyIncome < 1500
      monthlyIncome * 0.01
    else
      monthlyIncome * 0.02
    end
  end
    
end
