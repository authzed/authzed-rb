require 'grpc'

module Authzed
  module Api
    module V1alpha1
      class Client

        attr_reader :schema_service

        def initialize(target:, token:, credentials: nil, options: {}, timeout: nil)
          bearer = ::Authzed::GrpcUtil::BearerToken.new(token: token)
          creds = credentials || GRPC::Core::ChannelCredentials.new

          @schema_service = Authzed::Api::V1alpha1::SchemaService::Service::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: [bearer],
            channel_args: options,
          )
        end
      end
    end
  end
end

