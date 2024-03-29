# frozen_string_literal: true
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: authzed/api/v1/openapi.proto

require 'google/protobuf'

require 'protoc-gen-openapiv2/options/annotations_pb'


descriptor_data = "\n\x1c\x61uthzed/api/v1/openapi.proto\x12\x0e\x61uthzed.api.v1\x1a.protoc-gen-openapiv2/options/annotations.protoB\x80\x03\n\x12\x63om.authzed.api.v1Z2github.com/authzed/authzed-go/proto/authzed/api/v1\x92\x41\xb4\x02\x12\x9c\x01\n\x07\x41uthzed\"D\n\rAuthzed, Inc.\x12\x1ehttps://github.com/authzed/api\x1a\x13support@authzed.com*F\n\x12\x41pache 2.0 License\x12\x30https://github.com/authzed/api/blob/main/LICENSE2\x03\x31.0*\x03\x01\x02\x04\x32\x10\x61pplication/json:\x10\x61pplication/jsonZ#\n!\n\nApiKeyAuth\x12\x13\x08\x02\x1a\rAuthorization \x02rE\n\x1bMore about the Authzed API.\x12&https://docs.authzed.com/reference/apib\x06proto3"

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
    end
  end
end
