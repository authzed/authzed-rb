# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: authzed/api/v0/acl_service.proto for package 'authzed.api.v0'

require 'grpc'
require 'authzed/api/v0/acl_service_pb'

module Authzed
  module Api
    module V0
      module ACLService
        class Service

          include ::GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'authzed.api.v0.ACLService'

          rpc :Read, ::Authzed::Api::V0::ReadRequest, ::Authzed::Api::V0::ReadResponse
          rpc :Write, ::Authzed::Api::V0::WriteRequest, ::Authzed::Api::V0::WriteResponse
          rpc :Check, ::Authzed::Api::V0::CheckRequest, ::Authzed::Api::V0::CheckResponse
          rpc :ContentChangeCheck, ::Authzed::Api::V0::ContentChangeCheckRequest, ::Authzed::Api::V0::CheckResponse
          rpc :Expand, ::Authzed::Api::V0::ExpandRequest, ::Authzed::Api::V0::ExpandResponse
          rpc :Lookup, ::Authzed::Api::V0::LookupRequest, ::Authzed::Api::V0::LookupResponse
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
