class Holiday < ActiveRecord::Base
  attr_accessible :date, :description, :holiday_type, :rate
end
