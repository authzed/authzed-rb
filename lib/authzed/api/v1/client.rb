require 'grpc'

module Authzed
  module Api
    module V1
      class Client
        attr_reader :permissions_service, :schema_service, :watch_service, :experimental_service

        def initialize(target:, credentials: nil, interceptors: [], options: {}, timeout: nil)
          creds = credentials || GRPC::Core::ChannelCredentials.new

          @permissions_service = Authzed::Api::V1::PermissionsService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: interceptors,
            channel_args: options,
          )
          @schema_service = Authzed::Api::V1::SchemaService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: interceptors,
            channel_args: options,
          )
          @watch_service = Authzed::Api::V1::WatchService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: interceptors,
            channel_args: options,
          )
          @experimental_service = Authzed::Api::V1::ExperimentalService::Stub.new(
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
