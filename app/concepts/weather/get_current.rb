class Weather::GetCurrent < Weather::Base
  step :get_current

  def get_current(options, **)
    options['result'] = TemperatureRecordSerializer.new(TemperatureRecord.current).as_json

    # raw_weather = AccuWeather::Fetcher::Current.new.call.first
    # options['result'] = weather_presenter.new(raw_weather).call
  end
end
