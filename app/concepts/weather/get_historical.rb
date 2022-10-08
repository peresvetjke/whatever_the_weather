class Weather::GetHistorical < Weather::Base
  step :get_historical

  def get_historical(options, **)
    raw_weather_records = AccuWeather::Fetcher::Historical.new.call
    options['result'] = raw_weather_records.map { |w| weather_presenter.new(w).call }
  end
end
