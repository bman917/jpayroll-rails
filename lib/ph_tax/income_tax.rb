module PhTax::IncomeTax

  def self.annual(annual_taxable_income, year=Time.now.year)
    formula = get_income_tax_formula(year)
    formula.call(annual_taxable_income)
  end

  def self.get_income_tax_formula(year)
    # We only have 1 version for now
    INCOME_TAX_2012
  end

  def self.exemption(status, number_of_dependents, year=Time.now.year)
    get_tax_exemption_formula(year).call(status, number_of_dependents)
  end

  def self.get_tax_exemption_formula(year)
    TAX_EXEMPTION_2012
  end

  TAX_EXEMPTION_2012 = lambda do | status, number_of_dependents|

    exemption_per_dependent = 25000.00;
    tax_exemption = {
      single: 50000.00,
      married: 50000.00
    };

    total = 0
    total += tax_exemption[status]

    number_of_dependents = 4 if number_of_dependents > 4
    total += exemption_per_dependent * number_of_dependents
  end

  INCOME_TAX_2012 = lambda do | annual_taxable_income |
    bracket = []
    bracket[0] =      0.00
    bracket[1] =  10000.00
    bracket[2] =  30000.00
    bracket[3] =  70000.00
    bracket[4] = 140000.00

    bracket[5] = 250000.00
    bracket[6] = 500000.00

    #Map the bracket into a Hash where in key='bracket value' and value='bracket index'
    bracket_hash = Hash[bracket.map.with_index{|*ki| ki}]

    inc = annual_taxable_income

    t = {tax: 0.00, bracket: 0.00, percentage: 0.00, add_on: 0.00}

    calc = lambda do |bracket, percentage_param, add_on|
      inc_tax = ((inc - bracket) * percentage_param) + add_on
      t = {tax: inc_tax, bracket: bracket_hash[bracket], percentage: percentage_param, add_on: add_on}
      if inc_tax <= 0
        t[:tax] = 0.00
        t[:bracket] = 0.00
        t[:percentage] = 0.00
      end
    end

    calc.call(bracket[0], 0.05,     0.00)  if inc <= bracket[1]
    calc.call(bracket[1], 0.10,   500.00)  if inc.between? bracket[1], bracket[2]
    calc.call(bracket[2], 0.15,  2500.00)  if inc.between? bracket[2], bracket[3]
    calc.call(bracket[3], 0.20,  8500.00)  if inc.between? bracket[3], bracket[4]
    calc.call(bracket[4], 0.25, 22500.00)  if inc.between? bracket[4], bracket[5]
    calc.call(bracket[5], 0.30, 50000.00)  if inc.between? bracket[5], bracket[6]
    calc.call(bracket[6], 0.32, 125000.00) if inc > bracket[6]

    return t
  end

end
