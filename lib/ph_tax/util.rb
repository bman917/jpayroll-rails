
module PhTax::Util

  def self.calc_tax(income, options={})

    options[:year] ||= Time.now.year
    options[:month_number] ||= 1
    
    options[:status] ||= :single
    options[:dependents] ||= 0
    
    options[:reg_monthly_income] ||= income
    options[:auto_calculate_ytds] ||=false

    options[:ytd_tax] ||= 0
    options[:ytd_inc] ||= 0

    options[:extra_income] ||= 0
    options[:deductions] ||= 0

    month = options[:month_number].to_i
    dependents = options[:dependents].to_i

    reg_monthly_income = options[:reg_monthly_income]
    ytd_inc = options[:ytd_inc].to_f
    ytd_tax = options[:ytd_tax].to_f

    extra_income = options[:extra_income].to_f
    deductions = options[:deductions].to_f

    sss         = PhTax::Sss.calc(reg_monthly_income )
    pagibig     = PhTax::PagIbig.calc(reg_monthly_income)
    phil_health = PhTax::PhilHealth.calc(reg_monthly_income)
    exemption   = PhTax::IncomeTax.exemption(options[:status], dependents)

    total_contributions = (sss + phil_health + pagibig) * 12.00
    total_contributions = 30000 if total_contributions > 30000

    this_months_inc = income + extra_income - deductions
    remain_months = 12.00 - month
    
    proj_inc = this_months_inc + (this_months_inc * (remain_months)) + ytd_inc
    ann_taxable_inc = proj_inc - exemption - total_contributions
    ann_taxable_inc = 0.00 if ann_taxable_inc < 0
    monthly_taxable_income = (ann_taxable_inc/(12)).round(4)

    annual_income_tax = PhTax::IncomeTax.annual(ann_taxable_inc)
    tax_to_pay = annual_income_tax[:tax] - ytd_tax

    monthly_tax = (tax_to_pay/(remain_months + 1.00)).round(4)
    net_monthly_pay = this_months_inc - sss - phil_health - pagibig - monthly_tax
    ytd_tax = (monthly_tax + ytd_tax).round(4)

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
      net_monthly_pay: net_monthly_pay,
      new_ytd_inc: (ytd_inc + this_months_inc).round(4),
      new_ytd_tax: ytd_tax
    }

    tax.merge(annual_income_tax)

  end
end
