# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Holiday.create(
   date: Date.new(2012, 01, 01),
   description: %{New Year's Day},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 4, 5),
   description: %{Maundy Thursday},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 4, 6),
   description: %{Good Friday},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 4, 9),
   description: %{Araw ng Kagitingan},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 5, 1),
   description: %{Labor Day},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 6, 12),
   description: %{Independence Day},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 8, 27),
   description: %{National Heroes Day},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 11, 30),
   description: %{Bonifacio Day},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 12, 25),
   description: %{Christmas Day},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 12, 30),
   description: %{Rizal Day},
   holiday_type: HolidayType::NAMES_MAP[:regular],
   rate: 100.00
)
Holiday.create(
   date: Date.new(2012, 1, 23),
   description: %{Chinese New Year},
   holiday_type: HolidayType::NAMES_MAP[:special],
   rate: 30.00
)
Holiday.create(
   date: Date.new(2012, 8, 21),
   description: %{Ninoy Aquino Day},
   holiday_type: HolidayType::NAMES_MAP[:special],
   rate: 30.00
)
Holiday.create(
   date: Date.new(2012, 11, 1),
   description: %{All Saints Day},
   holiday_type: HolidayType::NAMES_MAP[:special],
   rate: 30.00
)
Holiday.create(
   date: Date.new(2012, 11, 2),
   description: %{All Souls Day},
   holiday_type: HolidayType::NAMES_MAP[:additional],
   rate: 30.00
)
Holiday.create(
   date: Date.new(2012, 12, 31),
   description: %{Last Day of the Year},
   holiday_type: HolidayType::NAMES_MAP[:special],
   rate: 30
)