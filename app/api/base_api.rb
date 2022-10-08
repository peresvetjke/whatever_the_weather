class BaseApi < Grape::API
  mount WeatherV1
end
