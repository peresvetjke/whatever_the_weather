class CreateTemperatureRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :temperature_records do |t|
      t.float :temperature_celsius, null: false
      t.datetime :date_time, null: false, unique: true

      t.timestamps
    end
  end
end
