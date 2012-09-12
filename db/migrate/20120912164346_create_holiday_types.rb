class CreateHolidayTypes < ActiveRecord::Migration
  def change
    create_table :holiday_types do |t|

      t.timestamps
    end
  end
end
