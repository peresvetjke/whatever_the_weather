require 'grape-swagger'

class WeatherV1 < Grape::API
  include ::Defaults

  prefix "api"
  version "v1", using: :path

  namespace 'weather' do
    desc 'Current temperature'
    get('current') do
      error!('Not found', 404) unless temperature_record = TemperatureRecord.current

      temperature_record
    end

    desc 'Historical temperature for last 24 hours'
    get('historical') do
      temperature_records = TemperatureRecord.last_24_hours
      error!('Not found', 404) unless temperature_records.present?

      render temperature_records, each_serializer: TemperatureRecordSerializer
    end

    desc 'Maximum temperature of last 24 hours'
    get 'max' do
      max = TemperatureRecord.max_of_last_24_hours
      error!('Not found', 404) unless max

      max
    end

    desc 'Minimum temperature of last 24 hours'
    get 'min' do
      min = TemperatureRecord.min_of_last_24_hours
      error!('Not found', 404) unless min

      min
    end

    desc 'Average temperature for last 24 hours'
    get 'avg' do
      avg = TemperatureRecord.avg_of_last_24_hours
      error!('Not found', 404) unless avg

      avg
    end

    desc 'Temperature by timestamp'
    get 'by_time/:timestamp' do
      params do
        requires :timestamp, type: Integer, desc: 'Timestamp'
      end

      error!('Bad request: timestamp should be positive integer', 400) unless params[:timestamp].to_i > 0

      value = TemperatureRecord.by_timestamp(params[:timestamp].to_i)&.temperature_celsius
      error!('Not found', 404) unless value

      value
    end
  end

  desc 'Backend status'
  get 'health' do
    'OK'
  end

  add_swagger_documentation
end