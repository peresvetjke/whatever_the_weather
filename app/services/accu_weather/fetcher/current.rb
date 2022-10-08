module AccuWeather
  module Fetcher
    class Current < Base
      def call
        @raw_record = super.first
        TemperatureRecord.new(temperature_celsius: temperature_celsius, date_time: date_time)
      end

      private

      # @return [String]
      def url
        File.join(ROOT_PATH, LOCATION_KEY.to_s)
      end

      def temperature_celsius
        @raw_record.dig('Temperature', 'Metric', 'Value').to_f
      end

      def date_time
        DateTime.parse(@raw_record['LocalObservationDateTime'])
      end
    end
  end
end
