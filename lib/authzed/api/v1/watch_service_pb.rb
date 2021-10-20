# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: authzed/api/v1/watch_service.proto

require 'google/protobuf'

require 'authzed/api/v1/core_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("authzed/api/v1/watch_service.proto", :syntax => :proto3) do
    add_message "authzed.api.v1.WatchRequest" do
      repeated :object_types, :string, 1, json_name: "objectTypes"
      optional :optional_start_cursor, :message, 2, "authzed.api.v1.ZedToken", json_name: "optionalStartCursor"
    end
    add_message "authzed.api.v1.WatchResponse" do
      repeated :updates, :message, 1, "authzed.api.v1.RelationshipUpdate", json_name: "updates"
      optional :changes_through, :message, 2, "authzed.api.v1.ZedToken", json_name: "changesThrough"
    end
  end
end

module Authzed
  module Api
    module V1
      WatchRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.WatchRequest").msgclass
      WatchResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1.WatchResponse").msgclass
    end
  end
end
