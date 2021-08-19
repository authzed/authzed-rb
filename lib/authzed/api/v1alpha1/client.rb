require 'grpc'

module Authzed
  module Api
    module V1alpha1
      class Client

        attr_reader :schema_service

        def initialize(target:, credentials: nil, interceptors: [], options: {}, timeout: nil)
          creds = credentials || GRPC::Core::ChannelCredentials.new

          @schema_service = Authzed::Api::V1alpha1::SchemaService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: interceptors,
            channel_args: options,
          )
        end
      end
    end
  end
end

