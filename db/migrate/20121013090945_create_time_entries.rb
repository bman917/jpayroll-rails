class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.integer :employee_id
      t.datetime :time_in
      t.datetime :time_out
      t.float :hours

      t.timestamps
    end
  end
end
