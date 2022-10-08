module AccuWeather
  class Updater
    def call
      save_temperature(fetch_weather)
    end

    private

    def fetch_weather
      @weather ||= AccuWeather::Fetcher::Current.new.call
    end

    def save_temperature(temperature)
      temperature_record = TemperatureRecord.find_or_initialize_by(date_time: temperature.date_time.beginning_of_hour)
      temperature_record.update(temperature_celsius: temperature.temperature_celsius)
    end
  end
end
