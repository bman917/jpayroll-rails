require 'test_helper'
require 'capybara/rails'

class SimpleTaxCalcTest < ActionDispatch::IntegrationTest

  include Capybara::DSL

  def teardown
  	Capybara.reset_sessions!
  	Capybara.use_default_driver
  	print 'teardown'
  end

  test "Tax Calc for Salary of Php25,000.00" do

 	    Capybara.current_driver = :selenium

  	  visit tax_sv_simple_path
  	  assert has_content?("Monthly Income"), "Did not find content"
  	  fill_in 'income', with: '25000.00'
  	  click_button 'Submit'
  	  sleep 3
  	  assert has_content?("Monthly Income"), "Did not find content"
  	  click_link 'Holidays'
  	  assert has_content?('Friday')

      print page.html
  end
end
