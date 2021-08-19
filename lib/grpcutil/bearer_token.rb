require 'grpc'

module Authzed
  module GrpcUtil
    class BearerToken < GRPC::ClientInterceptor

      AUTHORIZATION_HEADER = 'authorization'
      SCHEMA = 'Bearer'

      def initialize(token:)
        @token = token
      end

      ##
      # Intercept a unary request response call
      #
      # @param [Object] request
      # @param [GRPC::ActiveCall] call
      # @param [String] method
      # @param [Hash] metadata
      #
      def request_response(request: nil, call: nil, method: nil, metadata: nil)
        metadata[AUTHORIZATION_HEADER] = bearer_token_header
        yield
      end

      ##
      # Intercept a client streaming call
      #
      # @param [Enumerable] requests
      # @param [GRPC::ActiveCall] call
      # @param [String] method
      # @param [Hash] metadata
      #
      def client_streamer(requests: nil, call: nil, method: nil, metadata: nil)
        metadata[AUTHORIZATION_HEADER] = bearer_token_header
        yield
      end

      ##
      # Intercept a server streaming call
      #
      # @param [Object] request
      # @param [GRPC::ActiveCall] call
      # @param [String] method
      # @param [Hash] metadata
      #
      def server_streamer(request: nil, call: nil, method: nil, metadata: nil)
        metadata[AUTHORIZATION_HEADER] = bearer_token_header
        yield
      end

      ##
      # Intercept a BiDi streaming call
      #
      # @param [Enumerable] requests
      # @param [GRPC::ActiveCall] call
      # @param [String] method
      # @param [Hash] metadata
      #
      def bidi_streamer(requests: nil, call: nil, method: nil, metadata: nil)
        metadata[AUTHORIZATION_HEADER] = bearer_token_header
        yield
      end

      private

      def bearer_token_header
        "#{SCHEMA} #{token}"
      end
    end
  end
end
