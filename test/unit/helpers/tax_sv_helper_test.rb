require 'test_helper'
include TaxSvHelper

class TaxSvHelperTest < ActionView::TestCase

  test 'Test Calculate Income Tax (Accurate up until .15 cents)' do

    tax = nil
    
    calc = lambda do |expected, status, dependents, reg_income, month_income, month_num, ytd_tax, ytd_inc|
      tax = calc_tax(status, dependents, reg_income, month_income, month_num, ytd_tax, ytd_inc)
      msg = "Incorrect Monthly Income Tax Calculation: #{tax}"
      monthly = tax[:monthly_income_tax]
      assert_in_delta expected, monthly, 0.15, msg
    end

    
    #Expected results are calculated using
    #http://birtaxcalculator.com/calculators/bir_withholding_tax_computation_2009
    calc.call(5812.17, :single, 0, 32000.00, 32000.00, 1, 0, 0)
    calc.call(5187.27, :single, 1, 32000.00, 32000.00, 1, 0, 0)
    calc.call(4562.07, :single, 2, 32000.00, 32000.00, 1, 0, 0)
    calc.call(3975.50, :single, 3, 32000.00, 32000.00, 1, 0, 0)
    calc.call(3454.50, :single, 4, 32000.00, 32000.00, 1, 0, 0)

    calc.call(1510.83, :single, 0, 15000.00, 15000.00, 1, 0, 0)
    calc.call(1510.83, :single, 0, 15000.00, 15000.00, 2, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call( 520.08, :single, 0, 15000.00, 10000.00, 3, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 4, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 5, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 6, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 7, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 8, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 9, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 10, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 11, tax[:new_ytd_tax], tax[:new_ytd_inc])
    calc.call(1509.81, :single, 0, 15000.00, 15000.00, 12, tax[:new_ytd_tax], tax[:new_ytd_inc])
    puts tax
    
    msg = 'Incorrect Monthly Taxable Income'
    assert_in_delta 9429.16, tax[:monthly_taxable_income], 0.15, msg

    tax = calculate_tax(:single, 0, 15000.00, 0, 0, 1, 0, 0)
    assert_in_delta 1510.83, tax[:monthly_income_tax], 0.15
  end

  test 'Test Annual Tax calculation' do
    msg = 'Incorrect Annaul Tax calculation'
    assert_equal    250.00, calc_annual_tax(   5000.00)[:tax], msg
    assert_equal    500.00, calc_annual_tax(  10000.00)[:tax], msg
    assert_equal    500.10, calc_annual_tax(  10001.00)[:tax], msg
    assert_equal   3250.00, calc_annual_tax(  35000.00)[:tax], msg
    assert_equal  14500.00, calc_annual_tax( 100000.00)[:tax], msg
    assert_equal  17130.00, calc_annual_tax( 113150.00)[:tax], msg
    assert_equal  37500.00, calc_annual_tax( 200000.00)[:tax], msg
    assert_equal  65000.00, calc_annual_tax( 300000.00)[:tax], msg
    assert_equal 189000.00, calc_annual_tax( 700000.00)[:tax], msg
    assert_equal 324040.00, calc_annual_tax(1122000.00)[:tax], msg
  end

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
  
  
  test "Test SSS Contribution Calculation 2012" do
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
  
  test "Test Phil Health Contribution Claculation 2012" do
    philhealth_contribution_test  50.00,  2000.00
    philhealth_contribution_test  50.00,  4000.00
    philhealth_contribution_test 125.00, 10000.00
    philhealth_contribution_test 187.50, 15000.00
    philhealth_contribution_test 312.50, 25000.00
    philhealth_contribution_test 375.00, 30000.00
    philhealth_contribution_test 375.00, 50000.00   
  end
  
  def philhealth_contribution_test(expected, monthly)
    msg = 'Incorrect Phil Health contribution'
    assert_equal expected,   PHILHEALTH_2012.call(monthly), msg
  end

  test "Test Pag Ibig Contribution Calculation 2012" do
    assert_equal 300.00, calc_pagibig(15000.00)
    assert_equal 220.00, calc_pagibig(11000.00)
  end
  
end
