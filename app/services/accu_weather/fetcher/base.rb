module AccuWeather
  module Fetcher
    class Base
      LOCATION_KEY = 171705
      ROOT_PATH = 'http://dataservice.accuweather.com/currentconditions/v1'
      API_KEY = 'SA5lAHPDxgRTHoGxdUEA0vOx0SrGyEPu' # TODO move to credentials

      # @return [BasicObject] Result
      def call
        response_body
      end

      private

      # @return [JSON] Retrieved data about current weather.
      def response_body
        JSON.parse(make_request.body)
      end

      # @return [String]
      def url
        raise NotImplemented 'Not implemented for Abstract class'
      end

      # @return [Faraday::Response]
      def make_request
        @response ||= Faraday.new(
          url: url,
          params: { apikey: API_KEY }
        ).get
      end
    end
  end
end