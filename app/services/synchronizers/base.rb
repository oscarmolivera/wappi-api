module Synchronizers
  class Base
    class << self
      def conn
        Faraday.new('https://jsonplaceholder.typicode.com')
      end

      def parse_data(response)
        JSON.parse(response, symbolize_names: true)
      end
    end
  end
end
