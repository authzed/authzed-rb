require 'authzed'

client = Authzed::Api::V1::Client.new(
  target: 'grpc.authzed.com:443',
  interceptors: [Authzed::GrpcUtil::BearerToken.new(token: 'mytoken')],
)

emilia = Authzed::Api::V1::SubjectReference.new(
  object: Authzed::Api::V1::ObjectReference.new(
    object_type: 'blog/user',
    object_id: 'emilia'
  )
)

beatrice = Authzed::Api::V1::SubjectReference.new(
  object: Authzed::Api::V1::ObjectReference.new(
    object_type: 'blog/user',
    object_id: 'beatrice'
  )
)

post_one = Authzed::Api::V1::ObjectReference.new(
  object_type: "blog/post",
  object_id: "1"
)

client.permission_service.write_relationships(
  Authzed::Api::V1::WriteRelationshipsRequest.new(
    updates: [
      # Emilia is a Writer on Post 1
      Authzed::Api::V1::RelationshipUpdate.new(
        operation: Authzed::Api::V1::RelationshipUpdate::Operation::OPERATION_TOUCH,
        relationship: Authzed::Api::V1::Relationship.new(
          resource: post_one,
          relation: 'writer',
          subject: emilia,
        ),
      ),
      # Beatrice is a Reader on Post 1
      Authzed::Api::V1::RelationshipUpdate.new(
        operation: Authzed::Api::V1::RelationshipUpdate::Operation::OPERATION_TOUCH,
        relationship: Authzed::Api::V1::Relationship.new(
          resource: post_one,
          relation: 'reader',
          subject: beatrice,
        ),
      ),
    ]
  )
)
