module AccuWeather
  module Fetcher
    class Historical < Base
      PERIOD_HOURS = 24

      private

      def url
        File.join(ROOT_PATH, LOCATION_KEY.to_s, 'historical', PERIOD_HOURS.to_s)
      end
    end
  end
end
