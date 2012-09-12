class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.date :date
      t.string :description
      t.string :holiday_type
      t.decimal :rate

      t.timestamps
    end
  end
end
