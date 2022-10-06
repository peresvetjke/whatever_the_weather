class CreateTemperatureRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :temperature_records do |t|
      t.float :temperature_celsius
      t.datetime :local_observation_date_time

      t.timestamps
    end
  end
end
