class TimeEntry < ActiveRecord::Base
  attr_accessible :employee_id, :hours, :time_in, :time_out
  belongs_to :employee
  before_save :set_employee

  def set_employee
    self.employee_id = Employee.find_by_first_name("Juan").id
    self.hours = ((time_out - time_in)/60/60).to_f.round(2)
  end


end
