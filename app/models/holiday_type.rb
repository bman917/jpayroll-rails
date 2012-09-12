class HolidayType < ActiveRecord::Base
  NAMES = ['Special', 'Regular', 'Additional']
  NAMES_MAP = {special: NAMES[0], regular: NAMES[1], additional: NAMES[2]}
end