module TaxSvHelper

	def calc
		tax = 100.00;
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
  
  PHILHEALTH_2012 = lambda do |monthlyIncome|

    val = ((monthlyIncome/1000).floor * 12.50)
    val = 50  if monthlyIncome < 5000
    val = 375 if monthlyIncome >= 30000
    
    return val
  end


  
end
