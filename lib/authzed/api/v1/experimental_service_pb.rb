# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: authzed/api/v1/experimental_service.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'validate/validate_pb'
require 'google/protobuf/struct_pb'
require 'google/rpc/status_pb'
require 'authzed/api/v1/core_pb'
require 'authzed/api/v1/permission_service_pb'


descriptor_data = "\n)authzed/api/v1/experimental_service.proto\x12\x0e\x61uthzed.api.v1\x1a\x1cgoogle/api/annotations.proto\x1a\x17validate/validate.proto\x1a\x1cgoogle/protobuf/struct.proto\x1a\x17google/rpc/status.proto\x1a\x19\x61uthzed/api/v1/core.proto\x1a\'authzed/api/v1/permission_service.proto\"\xb0\x01\n\x1a\x42ulkCheckPermissionRequest\x12=\n\x0b\x63onsistency\x18\x01 \x01(\x0b\x32\x1b.authzed.api.v1.ConsistencyR\x0b\x63onsistency\x12S\n\x05items\x18\x02 \x03(\x0b\x32..authzed.api.v1.BulkCheckPermissionRequestItemB\r\xfa\x42\n\x92\x01\x07\"\x05\x8a\x01\x02\x10\x01R\x05items\"\xb6\x02\n\x1e\x42ulkCheckPermissionRequestItem\x12\x45\n\x08resource\x18\x01 \x01(\x0b\x32\x1f.authzed.api.v1.ObjectReferenceB\x08\xfa\x42\x05\x8a\x01\x02\x10\x01R\x08resource\x12J\n\npermission\x18\x02 \x01(\tB*\xfa\x42\'r%(@2!^([a-z][a-z0-9_]{1,62}[a-z0-9])?$R\npermission\x12\x44\n\x07subject\x18\x03 \x01(\x0b\x32 .authzed.api.v1.SubjectReferenceB\x08\xfa\x42\x05\x8a\x01\x02\x10\x01R\x07subject\x12;\n\x07\x63ontext\x18\x04 \x01(\x0b\x32\x17.google.protobuf.StructB\x08\xfa\x42\x05\x8a\x01\x02\x10\x00R\x07\x63ontext\"\xae\x01\n\x1b\x42ulkCheckPermissionResponse\x12\x41\n\nchecked_at\x18\x01 \x01(\x0b\x32\x18.authzed.api.v1.ZedTokenB\x08\xfa\x42\x05\x8a\x01\x02\x10\x00R\tcheckedAt\x12L\n\x05pairs\x18\x02 \x03(\x0b\x32\'.authzed.api.v1.BulkCheckPermissionPairB\r\xfa\x42\n\x92\x01\x07\"\x05\x8a\x01\x02\x10\x01R\x05pairs\"\xe2\x01\n\x17\x42ulkCheckPermissionPair\x12H\n\x07request\x18\x01 \x01(\x0b\x32..authzed.api.v1.BulkCheckPermissionRequestItemR\x07request\x12\x45\n\x04item\x18\x02 \x01(\x0b\x32/.authzed.api.v1.BulkCheckPermissionResponseItemH\x00R\x04item\x12*\n\x05\x65rror\x18\x03 \x01(\x0b\x32\x12.google.rpc.StatusH\x00R\x05\x65rrorB\n\n\x08response\"\xea\x01\n\x1f\x42ulkCheckPermissionResponseItem\x12j\n\x0epermissionship\x18\x01 \x01(\x0e\x32\x36.authzed.api.v1.CheckPermissionResponse.PermissionshipB\n\xfa\x42\x07\x82\x01\x04\x10\x01 \x00R\x0epermissionship\x12[\n\x13partial_caveat_info\x18\x02 \x01(\x0b\x32!.authzed.api.v1.PartialCaveatInfoB\x08\xfa\x42\x05\x8a\x01\x02\x10\x00R\x11partialCaveatInfo\"s\n\x1e\x42ulkImportRelationshipsRequest\x12Q\n\rrelationships\x18\x01 \x03(\x0b\x32\x1c.authzed.api.v1.RelationshipB\r\xfa\x42\n\x92\x01\x07\"\x05\x8a\x01\x02\x10\x01R\rrelationships\"@\n\x1f\x42ulkImportRelationshipsResponse\x12\x1d\n\nnum_loaded\x18\x01 \x01(\x04R\tnumLoaded\"\xb9\x02\n\x1e\x42ulkExportRelationshipsRequest\x12=\n\x0b\x63onsistency\x18\x01 \x01(\x0b\x32\x1b.authzed.api.v1.ConsistencyR\x0b\x63onsistency\x12\x31\n\x0eoptional_limit\x18\x02 \x01(\rB\n\xfa\x42\x07*\x05\x18\x90N(\x00R\roptionalLimit\x12?\n\x0foptional_cursor\x18\x03 \x01(\x0b\x32\x16.authzed.api.v1.CursorR\x0eoptionalCursor\x12\x64\n\x1coptional_relationship_filter\x18\x04 \x01(\x0b\x32\".authzed.api.v1.RelationshipFilterR\x1aoptionalRelationshipFilter\"\xad\x01\n\x1f\x42ulkExportRelationshipsResponse\x12\x46\n\x13\x61\x66ter_result_cursor\x18\x01 \x01(\x0b\x32\x16.authzed.api.v1.CursorR\x11\x61\x66terResultCursor\x12\x42\n\rrelationships\x18\x02 \x03(\x0b\x32\x1c.authzed.api.v1.RelationshipR\rrelationships2\xad\x04\n\x13\x45xperimentalService\x12\xb2\x01\n\x17\x42ulkImportRelationships\x12..authzed.api.v1.BulkImportRelationshipsRequest\x1a/.authzed.api.v1.BulkImportRelationshipsResponse\"4\x82\xd3\xe4\x93\x02.\")/v1/experimental/relationships/bulkimport:\x01*(\x01\x12\xb2\x01\n\x17\x42ulkExportRelationships\x12..authzed.api.v1.BulkExportRelationshipsRequest\x1a/.authzed.api.v1.BulkExportRelationshipsResponse\"4\x82\xd3\xe4\x93\x02.\")/v1/experimental/relationships/bulkexport:\x01*0\x01\x12\xab\x01\n\x13\x42ulkCheckPermission\x12*.authzed.api.v1.BulkCheckPermissionRequest\x1a+.authzed.api.v1.BulkCheckPermissionResponse\";\x82\xd3\xe4\x93\x02\x35\"0/v1/experimental/permissions/bulkcheckpermission:\x01*BH\n\x12\x63om.authzed.api.v1Z2github.com/authzed/authzed-go/proto/authzed/api/v1b\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool

begin
  pool.add_serialized_file(descriptor_data)
rescue TypeError
  # Compatibility code: will be removed in the next major version.
  require 'google/protobuf/descriptor_pb'
  parsed = Google::Protobuf::FileDescriptorProto.decode(descriptor_data)
  parsed.clear_dependency
  serialized = parsed.class.encode(parsed)
  file = pool.add_serialized_file(serialized)
  warn "Warning: Protobuf detected an import path issue while loading generated file #{__FILE__}"
  imports = [
    ["authzed.api.v1.Consistency", "authzed/api/v1/permission_service.proto"],
    ["authzed.api.v1.ObjectReference", "authzed/api/v1/core.proto"],
    ["google.protobuf.Struct", "google/protobuf/struct.proto"],
    ["google.rpc.Status", "google/rpc/status.proto"],
  ]
  imports.each do |type_name, expected_filename|
    import_file = pool.lookup(type_name).file_descriptor
    if import_file.name != expected_filename
      warn "- #{file.name} imports #{expected_filename}, but that import was loaded as #{import_file.name}"
    end
  end
  warn "Each proto file must use a consistent fully-qualified name."
  warn "This will become an error in the next major version."
end

module Authzed
  module Api
    module V1
      BulkCheckPermissionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkCheckPermissionRequest").msgclass
      BulkCheckPermissionRequestItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkCheckPermissionRequestItem").msgclass
      BulkCheckPermissionResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkCheckPermissionResponse").msgclass
      BulkCheckPermissionPair = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkCheckPermissionPair").msgclass
      BulkCheckPermissionResponseItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkCheckPermissionResponseItem").msgclass
      BulkImportRelationshipsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkImportRelationshipsRequest").msgclass
      BulkImportRelationshipsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkImportRelationshipsResponse").msgclass
      BulkExportRelationshipsRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkExportRelationshipsRequest").msgclass
      BulkExportRelationshipsResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.BulkExportRelationshipsResponse").msgclass
    end
  end
end
