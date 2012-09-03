require 'test_helper'
include TaxSvHelper

class TaxSvHelperTest < ActionView::TestCase

  test "Test Personal Exemption calculation" do
   
    personal_exemption_test(:single,  0, 50000.00)
    personal_exemption_test(:single,  1, 75000.00)
    personal_exemption_test(:married, 0, 50000.00)
    personal_exemption_test(:married, 1, 75000.00)
    personal_exemption_test(:married, 2, 100000.00)
    personal_exemption_test(:married, 4, 150000.00)
    personal_exemption_test(:married, 10, 150000.00)
    
  end
  
  def personal_exemption_test(status, dependents, expected)
    msg = 'Incorrect personal tax exemption.'
	assert_equal calc_personal_tax_exemption( status, dependents),  expected    ,msg  
  end
  
  
  test "Test SSS Contribution calculation" do
  
    sss_contriubtion_test(  500.00,    0.00,   0.00)
	sss_contriubtion_test( 1000.00,   70.70,  33.30)
	sss_contriubtion_test( 5250.00,  388.70, 183.30)
	sss_contriubtion_test(10000.00,  706.70, 333.30)
	sss_contriubtion_test(14000.00,  989.30, 466.70)
	sss_contriubtion_test(15000.00, 1060.00, 500.00)
    sss_contriubtion_test(30000.00, 1060.00, 500.00)
    
  end
  
  def sss_contriubtion_test(monthlyIncome, er, ee)
    msg = 'Incorrect SSS contribution'
    expected = { er: er, ee: ee }
    assert_equal expected, SSS_2012.call(monthlyIncome), msg
  end
  
end
