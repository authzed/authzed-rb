# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: authzed/api/v1alpha1/schema.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "authzed.api.v1alpha1.ReadSchemaRequest" do
    repeated :object_definitions_names, :string, 1
  end
  add_message "authzed.api.v1alpha1.ReadSchemaResponse" do
    repeated :object_definitions, :string, 1
  end
  add_message "authzed.api.v1alpha1.WriteSchemaRequest" do
    optional :schema, :string, 1
  end
  add_message "authzed.api.v1alpha1.WriteSchemaResponse" do
    repeated :object_definitions_names, :string, 1
  end
end

module Authzed
  module Api
    module V1alpha1
      ReadSchemaRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1alpha1.ReadSchemaRequest").msgclass
      ReadSchemaResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1alpha1.ReadSchemaResponse").msgclass
      WriteSchemaRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1alpha1.WriteSchemaRequest").msgclass
      WriteSchemaResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("authzed.api.v1alpha1.WriteSchemaResponse").msgclass
    end
  end
end
