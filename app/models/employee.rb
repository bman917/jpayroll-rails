class Employee < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :middle_name
  has_many :time_entries, dependent: :destroy
end
