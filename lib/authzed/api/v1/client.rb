require 'grpc'

require_relative 'schema_services_pb'
require_relative 'watch_service_services_pb'
require_relative 'permission_service_services_pb'

module Authzed
  module Api
    module V1
      class Client
        attr_reader :permission_service, :schema_service, :watch_service

        def initialize(target:, credentials: nil, interceptors: [], options: {}, timeout: nil)
          creds = credentials || GRPC::Core::ChannelCredentials.new

          @permission_service = PermissionService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: interceptors,
            channel_args: options,
          )
          @schema_service = SchemaService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: interceptors,
            channel_args: options,
          )
          @watch_service = WatchService::Stub.new(
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
