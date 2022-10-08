class Weather::Base < Trailblazer::Operation
  private

  def weather_presenter
    AccuWeather::WeatherPresenter
  end
end
