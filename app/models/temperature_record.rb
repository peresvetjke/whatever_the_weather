class TemperatureRecord < ApplicationRecord
  validates :temperature_celsius, :local_observation_date_time, presence: true
end
