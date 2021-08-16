require 'grpc'

module Authzed
  module Api
    module V0
      class Client
        attr_reader :acl_service, :developer_service, :namespace_service, :watch_service

        def initialize(target:, token:, credentials: nil, options: {}, timeout: nil)
          bearer = ::Authzed::GrpcUtil::BearerToken.new(token: token)
          creds = credentials || GRPC::Core::ChannelCredentials.new

          @acl_service = ACLService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: [bearer],
            channel_args: options,
          )
          @developer_service = DeveloperService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: [bearer],
            channel_args: options,
          )
          @namespace_service = NamespaceService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: [bearer],
            channel_args: options,
          @watch_service = WatchService::Stub.new(
            target,
            creds,
            timeout: timeout,
            interceptors: [bearer],
            channel_args: options,
          )
        end
      end

      class User
        def initialize(namespace:, object_id:)
          Authzed::Api::V0::ObjectAndRelation.new(
            namespace: namespace,
            object_id: object_id,
            relation: '...',
          )
        end
      end
    end
  end
end
