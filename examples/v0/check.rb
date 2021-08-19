require 'authzed'

# See write.rb example for user relationships
emilia = Authzed::Api::V0::Client.user(namespace: 'blog/user', object_id: 'emilia')
beatrice = Authzed::Api::V0::Client.user(namespace: 'blog/user', object_id: 'beatrice')

post_one_reader = Authzed::Api::V0::ObjectAndRelation.new(
  namespace: 'blog/post',
  object_id: '1',
  relation: 'reader')

post_one_writer = Authzed::Api::V0::ObjectAndRelation.new(
  namespace: 'blog/post',
  object_id: '1',
  relation: 'writer')

client = Authzed::Api::V0::Client.new(
  target: 'grpc.authzed.com:443',
  interceptors: [Authzed::GrpcUtil::BearerToken.new(token: 'mytoken')],
)

resp = client.acl_service.check(
  Authzed::Api::V0::CheckRequest.new(test_userset: post_one_reader, user: emilia)
)
raise unless resp.is_member

resp = client.acl_service.check(
  Authzed::Api::V0::CheckRequest.new(test_userset: post_one_writer, user: emilia)
)
raise unless resp.is_member

resp = client.acl_service.check(
  Authzed::Api::V0::CheckRequest.new(test_userset: post_one_reader, user: beatrice)
)
raise unless resp.is_member

resp = client.acl_service.check(
  Authzed::Api::V0::CheckRequest.new(test_userset: post_one_writer, user: beatrice)
)
raise if resp.is_member


