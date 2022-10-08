module AccuWeather
  class Updater
    def call
      raw_record = fetch_weather
      temperature_celsius = raw_record.dig('Temperature', 'Metric', 'Value')
      date_time = DateTime.parse(raw_record['LocalObservationDateTime']).beginning_of_hour
      save_temperature(date_time, temperature_celsius)
    end

    private

    def fetch_weather
      AccuWeather::Fetcher::Current.new.call.first
    end

    def save_temperature(date_time, temperature_celsius)
      temperature_record = TemperatureRecord.find_or_initialize_by(date_time: date_time)
      temperature_record.update(temperature_celsius: temperature_celsius)
    end
  end
end
