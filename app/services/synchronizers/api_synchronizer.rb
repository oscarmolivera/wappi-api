module Synchronizers
  class ApiSynchronizer < Synchronizers::Base
    class << self
      
      def endpoints_by_models
        {
          users: '/users',
          posts: '/posts',
          comments: '/comments'
        }
      end

      def call()
        populate_models
      end

      #private

      def fetch_data_from_api(endpoint)
        response = conn.get(endpoint)
        parse_data(response.body)
      end

      def populate_models
        endpoints_by_models.each do |model, endpoint|
          Synchronizers::ModelPopulator.call(model, fetch_data_from_api(endpoint))
        end
      end
    end
  end
end
