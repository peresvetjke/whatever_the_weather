require 'rails_helper'

describe AccuWeather::WeatherPresenter do
  subject { described_class.new(raw_weather_record).call }

  let(:raw_weather_record) do
    {
      "LocalObservationDateTime" => "2022-10-06T22:13:00+04:00",
      "EpochTime" => 1665079980,
      "WeatherText" => "Mostly cloudy",
      "WeatherIcon" => 38,
      "HasPrecipitation" => false,
      "PrecipitationType" => 'null',
      "IsDayTime" => false,
      "Temperature" => {
          "Metric" => {
              "Value" => 21.1,
              "Unit" => "C",
              "UnitType" => 17
          },
          "Imperial" => {
              "Value" => 70,
              "Unit" => "F",
              "UnitType" => 18
          }
      },
      "MobileLink" => "http://www.accuweather.com/en/ge/tbilisi/171705/current-weather/171705?lang=en-us",
      "Link" => "http://www.accuweather.com/en/ge/tbilisi/171705/current-weather/171705?lang=en-us"
    }
  end
  let(:date_time) { DateTime.parse('2022-10-06T22:13:00+04:00').beginning_of_hour.iso8601 }
  let(:result) { { value: 21.1, date_time: date_time, unit: '°C' } }

  it { is_expected.to eq result }
end
