module PhTax::Sss

  def self.calc(monthly_income, year=Time.now.year, type=:employee)
    formula = PhTax::Sss.get_sss_formula(year)
    formula.call(monthly_income)[type]
  end

  def self.get_sss_formula (year)
    # We only have 1 version for now
    return SSS_2012
  end

  #TODO: I have to think of a way so that this may never be changed
  #=================================================
  #    SSS Contribution Table 2012
  #=================================================

  SSS_2012 = lambda do |monthlyIncome|

    inc = monthlyIncome
    o = { employer: 0, employee: 0 }

    o = {employer:  70.70, employee: 33.30 } if inc.between?(1000, 1249.99)
    o = {employer: 141.30, employee: 66.70}  if inc.between?(1750, 2249.99)
    o = {employer: 176.70, employee: 83.30}  if inc.between?(2250, 2749.99)
    o = {employer: 212.00, employee: 100.00} if inc.between?(2750, 3249.99)
    o = {employer: 247.30, employee: 116.70} if inc.between?(3250, 3749.99)
    o = {employer: 282.70, employee: 133.30} if inc.between?(3750, 4249.99)
    o = {employer: 318.00, employee: 150.00} if inc.between?(4250, 4749.99)
    o = {employer: 353.30, employee: 166.70} if inc.between?(4750, 5249.99)
    o = {employer: 388.70, employee: 183.30} if inc.between?(5250, 5749.99)
    o = {employer: 424.00, employee: 200.00} if inc.between?(5750, 6249.99)
    o = {employer: 459.30, employee: 216.70} if inc.between?(6250, 6749.99)
    o = {employer: 494.70, employee: 233.30} if inc.between?(6750, 7249.99)
    o = {employer: 530.00, employee: 250.00} if inc.between?(7250, 7749.99)
    o = {employer: 565.30, employee: 266.70} if inc.between?(7750, 8249.99)
    o = {employer: 600.70, employee: 283.30} if inc.between?(8250, 8749.99)
    o = {employer: 636.00, employee: 300.00} if inc.between?(8750, 9249.99)
    o = {employer: 671.30, employee: 316.70} if inc.between?(9250, 9749.99)
    o = {employer: 706.70, employee: 333.30} if inc.between?(9750, 10249.99)
    o = {employer: 742.00, employee: 350.00} if inc.between?(10250,10749.99)
    o = {employer: 777.30, employee: 366.70} if inc.between?(10750,11249.99)
    o = {employer: 812.70, employee: 383.30} if inc.between?(11250,11749.99)
    o = {employer: 848.00, employee: 400.00} if inc.between?(11750,12249.99)
    o = {employer: 883.33, employee: 416.70} if inc.between?(12250,12749.99)
    o = {employer: 918.70, employee: 433.30} if inc.between?(12750,13249.99)
    o = {employer: 954.00, employee: 450.00} if inc.between?(13250,13749.99)
    o = {employer: 989.30, employee: 466.70} if inc.between?(13750,14249.99)
    o = {employer: 1024.70, employee: 483.30} if inc.between?(14250,14749.99)
    o = {employer: 1060.00, employee: 500.00} if inc >= 14750
    return o
  end
end
