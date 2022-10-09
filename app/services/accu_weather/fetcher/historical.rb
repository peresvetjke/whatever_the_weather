module AccuWeather
  module Fetcher
    class Historical < Base
      PERIOD_HOURS = 24

      def call
        raw_records = super
        raw_records.map do |raw_record|
          temperature_from_raw_record(raw_record)
        end
      end

      private

      def url
        File.join(ROOT_PATH, LOCATION_KEY.to_s, 'historical', PERIOD_HOURS.to_s)
      end
    end
  end
end
