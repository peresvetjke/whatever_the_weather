module AccuWeather
  module Fetcher
    class Current < Base
      private

      # @return [String]
      def url
        File.join(ROOT_PATH, LOCATION_KEY.to_s)
      end
    end
  end
end
