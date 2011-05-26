module Paseo
  module Helpers
    module Sinatra

      #
      # Given a ruby |hash|, convert it to json
      #
      def json(hash={})
        content_type 'application/json'
        Yajl::Encoder.encode(hash)
      end

    end
  end
end
