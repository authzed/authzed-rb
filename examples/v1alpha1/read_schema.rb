require 'authzed'

client = Authzed::Api::V1alpha1::Client.new(
  target: 'grpc.authzed.com:443',
  interceptors: [Authzed::GrpcUtil::BearerToken.new(token: 'mytoken')],
)

resp = client.schema_service.read_schema(
  Authzed::Api::V1alpha1::ReadSchemaRequest.new(
    object_definitions_names: ['example/user']
  )
)
puts resp.object_definitions
