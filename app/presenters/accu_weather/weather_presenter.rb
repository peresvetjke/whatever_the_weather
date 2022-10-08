module AccuWeather
  class WeatherPresenter
    def initialize(weather)
      @weather = weather
    end

    def call
      { value: temperature_in_celsius, unit: '°C', date_time: date_time }
    end

    private

    def temperature_in_celsius
      @weather.dig('Temperature', 'Metric', 'Value')
    end

    def date_time
      DateTime.parse(@weather['LocalObservationDateTime']).beginning_of_hour.iso8601
    end
  end
end
