module PhTax::PhilHealth

  def self.calc(monthly_income, year=Time.now.year)
    formula = get_phil_health_formula(year)
    formula.call(monthly_income)
  end

  def self.get_phil_health_formula (year)
    # We only have 1 version for now
    PHILHEALTH_2012
  end

  PHILHEALTH_2012 = lambda do |monthlyIncome|
    val = ((monthlyIncome/1000).floor * 12.50)
    val = 50  if monthlyIncome < 5000
    val = 375 if monthlyIncome >= 30000
    return val
  end
    
end
