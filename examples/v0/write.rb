require 'authzed'

client = Authzed::Api::V0::Client.new(
  target: 'grpc.authzed.com:443',
  interceptors: [Authzed::GrpcUtil::BearerToken.new(token: 'mytoken')],
)

client.acl_service.write(
  Authzed::Api::V0::WriteRequest.new(
    updates: [
      # Emilia is a Writer on Post 1
      Authzed::Api::V0::RelationTupleUpdate(
        operation: Authzed::Api::V0::RelationTupleUpdate::Operation::CREATE,
        tuple: RelationTuple(
          user: Authzed::Api::V0::User.new(namespace: 'blog/user', object_id: 'emilia'),
          object_and_relation: Authzed::Api::V0::ObjectAndRelation.new(
            namespace: 'blog/post',
            object_id: '1',
            relation: 'writer'
          ),
        ),
      ),
      # Beatrice is a Reader on Post 1
      Authzed::Api::V0::RelationTupleUpdate(
        operation: Authzed::Api::V0::RelationTupleUpdate::Operation::CREATE,
        tuple: RelationTuple(
          user: Authzed::Api::V0::User.new(namespace: 'blog/user', object_id: 'beatrice'),
          object_and_relation: Authzed::Api::V0::ObjectAndRelation.new(
            namespace: 'blog/post',
            object_id: '1',
            relation: 'reader'
          ),
        ),
      ),
    ]
  )
)
