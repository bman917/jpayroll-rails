class Holiday < ActiveRecord::Base
  attr_accessible :date, :description, :holiday_type, :rate

  def self.find_by_month (month)
    year = Time.current.year
    max = Time.days_in_month(month, year)
    Holiday.where(date: (Date.new(year, month, 01)..(Date.new(year, (month), max))))
  end

  def short_date
    self.date.to_formatted_s(:short)
  end
end
