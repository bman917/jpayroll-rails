require 'bigdecimal'

module TaxSvHelper

  def calculate_tax(status, dependents, reg_monthly_inc, allowances, deductions,
    month_number, ytd_tax_paid, ytd_inc)

    this_months_inc = reg_monthly_inc + allowances - deductions
    calc_tax(status, dependents, reg_monthly_inc, this_months_inc, month_number,
      ytd_tax_paid, ytd_inc)
  end

  def calc_tax(status, dependents, reg_monthly_inc, this_months_inc,
    month_number, ytd_tax_paid, ytd_inc)

    exemption  = calc_personal_tax_exemption(status, dependents)
    sss        = calc_sss_contribution_2012(reg_monthly_inc)
    phil_health = calc_philhealth_2012(reg_monthly_inc)
    pagibig    = calc_pagibig(reg_monthly_inc)

    total_contributions = (sss[:ee] + phil_health + pagibig) * 12.00
    total_contributions = 30000 if total_contributions > 30000

    remain_months = 12.00 - month_number
    proj_inc = this_months_inc + (this_months_inc * (remain_months)) + ytd_inc
    ann_taxable_inc = proj_inc - exemption - total_contributions
    monthly_taxable_income = (ann_taxable_inc/(12)).round(4)
    
    annual_income_tax = calc_annual_tax(ann_taxable_inc)
    tax_to_pay = annual_income_tax[:tax] - ytd_tax_paid
    
    monthly_tax = (tax_to_pay/(remain_months + 1.00)).round(4)
    ytd_tax = (monthly_tax + ytd_tax_paid).round(4)

    tax = { 
      personal_exemption: exemption,
      sss_contribution: sss,
      phil_health_contribution: phil_health,
      pag_ibig_contribution: pagibig,
      total_contributions: total_contributions,
      remain_months: remain_months,
      projected_annual_income: proj_inc,
      taxable_inc: ann_taxable_inc,
      monthly_taxable_income: monthly_taxable_income,
      projected_annual_income_tax: annual_income_tax,
      remaining_tax_to_pay: tax_to_pay.round(4),
      monthly_income_tax: monthly_tax,
      new_ytd_inc: (ytd_inc + this_months_inc),
      new_ytd_tax: ytd_tax
    }

    tax.merge(annual_income_tax)
    

  end

  def calc_annual_tax(annual_taxable_income)
    
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

    tax = 0

    calc = lambda do |bracket, percentage, add_on|
      tax = ((inc - bracket) * percentage) + add_on
      inc_tax = {tax: tax, bracket: bracket_hash[bracket], percentage: percentage, add_on: add_on}
    end

    tax = calc.call(bracket[0], 0.05,     0.00)  if inc <= bracket[1]
    tax = calc.call(bracket[1], 0.10,   500.00)  if inc.between? bracket[1], bracket[2]
    tax = calc.call(bracket[2], 0.15,  2500.00)  if inc.between? bracket[2], bracket[3]
    tax = calc.call(bracket[3], 0.20,  8500.00)  if inc.between? bracket[3], bracket[4]
    tax = calc.call(bracket[4], 0.25, 22500.00)  if inc.between? bracket[4], bracket[5]
    tax = calc.call(bracket[5], 0.30, 50000.00)  if inc.between? bracket[5], bracket[6]
    tax = calc.call(bracket[6], 0.32, 125000.00) if inc > bracket[6]
    
    return tax
  end


  
#=================================================
#    Personal Excemptions --- START
#    RA 9504 SEC 4
#    ftp://ftp.bir.gov.ph/webadmin1/pdf/11_ra_9504_minimum_wage.pdf
#=================================================

  PHTaxExemptionsPerDependent = 25000.00;
  PHTaxExemptions = {
    single: 50000.00,
    married: 50000.00
   };
	
  def calc_personal_tax_exemption(status, numOfDependents)
	
    total = 0
    total += PHTaxExemptions[status]
    
    numOfDependents = 4 if numOfDependents > 4
    total += PHTaxExemptionsPerDependent * numOfDependents
  end
  
#=================================================
#    Start SSS Contribution Table 2012 --- END
#    http://www.sss.gov.ph/sss/printversion.jsp?id=111&file=regi_contrib_table.html
#=================================================
  
  def calc_sss_contribution_2012(monthlyIncome)

    SSS_2012.call monthlyIncome

  end

  
  SSS_2012 = lambda do |monthlyIncome|
    
    inc = monthlyIncome
    o = { er: 0, ee: 0 }
    
    o = {er:  70.70, ee: 33.30 } if inc.between?(1000, 1249.99) 
    o = {er: 141.30, ee: 66.70}  if inc.between?(1750, 2249.99)
    o = {er: 176.70, ee: 83.30}  if inc.between?(2250, 2749.99) 
    o = {er: 212.00, ee: 100.00} if inc.between?(2750, 3249.99) 
    o = {er: 247.30, ee: 116.70} if inc.between?(3250, 3749.99) 
    o = {er: 282.70, ee: 133.30} if inc.between?(3750, 4249.99) 
    o = {er: 318.00, ee: 150.00} if inc.between?(4250, 4749.99) 
    o = {er: 353.30, ee: 166.70} if inc.between?(4750, 5249.99) 
    o = {er: 388.70, ee: 183.30} if inc.between?(5250, 5749.99) 
    o = {er: 424.00, ee: 200.00} if inc.between?(5750, 6249.99) 
    o = {er: 459.30, ee: 216.70} if inc.between?(6250, 6749.99) 
    o = {er: 494.70, ee: 233.30} if inc.between?(6750, 7249.99) 
    o = {er: 530.00, ee: 250.00} if inc.between?(7250, 7749.99) 
    o = {er: 565.30, ee: 266.70} if inc.between?(7750, 8249.99) 
    o = {er: 600.70, ee: 283.30} if inc.between?(8250, 8749.99) 
    o = {er: 636.00, ee: 300.00} if inc.between?(8750, 9249.99) 
    o = {er: 671.30, ee: 316.70} if inc.between?(9250, 9749.99) 
    o = {er: 706.70, ee: 333.30} if inc.between?(9750, 10249.99) 
    o = {er: 742.00, ee: 350.00} if inc.between?(10250,10749.99) 
    o = {er: 777.30, ee: 366.70} if inc.between?(10750,11249.99) 
    o = {er: 812.70, ee: 383.30} if inc.between?(11250,11749.99) 
    o = {er: 848.00, ee: 400.00} if inc.between?(11750,12249.99) 
    o = {er: 883.33, ee: 416.70} if inc.between?(12250,12749.99) 
    o = {er: 918.70, ee: 433.30} if inc.between?(12750,13249.99) 
    o = {er: 954.00, ee: 450.00} if inc.between?(13250,13749.99) 
    o = {er: 989.30, ee: 466.70} if inc.between?(13750,14249.99) 
    o = {er: 1024.70, ee: 483.30} if inc.between?(14250,14749.99) 
    o = {er: 1060.00, ee: 500.00} if inc >= 14750
    return o
  end

  def calc_philhealth_2012(monthly_income)
    PHILHEALTH_2012.call(monthly_income)
  end
  
  PHILHEALTH_2012 = lambda do |monthlyIncome|
    val = ((monthlyIncome/1000).floor * 12.50)
    val = 50  if monthlyIncome < 5000
    val = 375 if monthlyIncome >= 30000
    return val
  end

  def calc_pagibig(monthlyIncome, option={})
    proc = option[:version] || PAGIBIG_2012
    proc.call(monthlyIncome)
  end

  PAGIBIG_2012 = lambda do |monthlyIncome|
    if monthlyIncome < 1500
      monthlyIncome * 0.01 
    else
      monthlyIncome * 0.02
    end
  end

end
