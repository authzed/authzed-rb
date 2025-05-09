# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: authzed/api/v1/experimental_service.proto for package 'authzed.api.v1'

require 'grpc'
require 'authzed/api/v1/experimental_service_pb'

module Authzed
  module Api
    module V1
      module ExperimentalService
        # ExperimentalService exposes a number of APIs that are currently being
        # prototyped and tested for future inclusion in the stable API.
        class Service

          include ::GRPC::GenericService

          self.marshal_class_method = :encode
          self.unmarshal_class_method = :decode
          self.service_name = 'authzed.api.v1.ExperimentalService'

          # BulkImportRelationships is a faster path to writing a large number of
          # relationships at once. It is both batched and streaming. For maximum
          # performance, the caller should attempt to write relationships in as close
          # to relationship sort order as possible: (resource.object_type,
          # resource.object_id, relation, subject.object.object_type,
          # subject.object.object_id, subject.optional_relation)
          # 
          # EXPERIMENTAL
          # https://github.com/authzed/spicedb/issues/1303
          rpc :BulkImportRelationships, stream(::Authzed::Api::V1::BulkImportRelationshipsRequest), ::Authzed::Api::V1::BulkImportRelationshipsResponse
          # BulkExportRelationships is the fastest path available to exporting
          # relationships from the server. It is resumable, and will return results
          # in an order determined by the server.
          rpc :BulkExportRelationships, ::Authzed::Api::V1::BulkExportRelationshipsRequest, stream(::Authzed::Api::V1::BulkExportRelationshipsResponse)
          # NOTE: BulkCheckPermission has been promoted to the stable API as "CheckBulkPermission" and the
          # API will be removed from experimental in a future release.
          rpc :BulkCheckPermission, ::Authzed::Api::V1::BulkCheckPermissionRequest, ::Authzed::Api::V1::BulkCheckPermissionResponse
          # DEPRECATED: Promoted to ReflectSchema in the stable API.
          rpc :ExperimentalReflectSchema, ::Authzed::Api::V1::ExperimentalReflectSchemaRequest, ::Authzed::Api::V1::ExperimentalReflectSchemaResponse
          # DEPRECATED: Promoted to ComputablePermissions in the stable API.
          rpc :ExperimentalComputablePermissions, ::Authzed::Api::V1::ExperimentalComputablePermissionsRequest, ::Authzed::Api::V1::ExperimentalComputablePermissionsResponse
          # DEPRECATED: Promoted to DependentRelations in the stable API.
          rpc :ExperimentalDependentRelations, ::Authzed::Api::V1::ExperimentalDependentRelationsRequest, ::Authzed::Api::V1::ExperimentalDependentRelationsResponse
          # DEPRECATED: Promoted to DiffSchema in the stable API.
          rpc :ExperimentalDiffSchema, ::Authzed::Api::V1::ExperimentalDiffSchemaRequest, ::Authzed::Api::V1::ExperimentalDiffSchemaResponse
          # EXPERIMENTAL: RegisterRelationshipCounter registers a new filter for counting relationships. A filter must be registered before
          # a count can be requested.
          rpc :ExperimentalRegisterRelationshipCounter, ::Authzed::Api::V1::ExperimentalRegisterRelationshipCounterRequest, ::Authzed::Api::V1::ExperimentalRegisterRelationshipCounterResponse
          # EXPERIMENTAL: CountRelationships returns the count of relationships for *pre-registered* filter.
          rpc :ExperimentalCountRelationships, ::Authzed::Api::V1::ExperimentalCountRelationshipsRequest, ::Authzed::Api::V1::ExperimentalCountRelationshipsResponse
          # EXPERIMENTAL: UnregisterRelationshipCounter unregisters an existing filter for counting relationships.
          rpc :ExperimentalUnregisterRelationshipCounter, ::Authzed::Api::V1::ExperimentalUnregisterRelationshipCounterRequest, ::Authzed::Api::V1::ExperimentalUnregisterRelationshipCounterResponse
        end

        Stub = Service.rpc_stub_class
      end
    end
  end
end
