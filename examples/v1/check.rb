require 'authzed'

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

client = Authzed::Api::V1::Client.new(
  target: 'grpc.authzed.com:443',
  interceptors: [Authzed::GrpcUtil::BearerToken.new(token: 'mytoken')],
)

resp = client.permissions_service.check_permission(
  Authzed::Api::V1::CheckPermissionRequest.new(
    resource: post_one,
    permission: 'read',
    subject: emilia, 
  )
)
raise unless resp.permissionship == CheckPermissionResponse::Permissionship::PERMISSIONSHIP_HAS_PERMISSION

resp = client.permissions_service.check_permission(
  Authzed::Api::V1::CheckPermissionRequest.new(
    resource: post_one,
    permission: 'write',
    subject: emilia, 
  )
)
raise unless resp.permissionship == CheckPermissionResponse::Permissionship::PERMISSIONSHIP_HAS_PERMISSION

resp = client.permissions_service.check_permission(
  Authzed::Api::V1::CheckPermissionRequest.new(
    resource: post_one,
    permission: 'read',
    subject: beatrice, 
  )
)
raise unless resp.permissionship == CheckPermissionResponse::Permissionship::PERMISSIONSHIP_HAS_PERMISSION

resp = client.permissions_service.check_permission(
  Authzed::Api::V1::CheckPermissionRequest.new(
    resource: post_one,
    permission: 'write',
    subject: beatrice, 
  )
)
raise if resp.permissionship == CheckPermissionResponse::Permissionship::PERMISSIONSHIP_HAS_PERMISSION