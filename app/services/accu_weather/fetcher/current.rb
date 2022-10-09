module AccuWeather
  module Fetcher
    class Current < Base
      def call
        raw_record = super.first
        temperature_from_raw_record(raw_record)
      end

      private

      def url
        File.join(ROOT_PATH, LOCATION_KEY.to_s)
      end
    end
  end
end
