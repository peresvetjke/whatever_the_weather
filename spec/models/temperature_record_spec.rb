require 'rails_helper'

RSpec.describe TemperatureRecord, type: :model do
  it { should validate_presence_of(:temperature_celsius) }
  it { should validate_presence_of(:local_observation_date_time) }
end
