require 'authzed'

test_schema = ''"/** document represents a document protected by Authzed. */
definition document {
	/** writer indicates that the user is a writer on the document. */
	relation writer: user

	/** reader indicates that the user is a reader on the document. */
	relation reader: user

	/** edit indicates that the user has permission to edit the document. */
	permission edit = writer

	/**
	 * view indicates that the user has permission to view the document, if they
	 * are a `reader` *or* have `edit` permission.
	 */
	permission view = reader + edit
}

/** project represents a project that can have issues created in it. */
definition project {
	/** writer indicates that the user is a writer on the document. */
	relation issue_creator: role#member
}

/** role represents a role that can be granted to a user. */
definition role {
	relation member: user
}

/** user represents a user that can be granted role(s) */
definition user {}"''

describe 'Client', '#schema' do
  let(:client) do
    Authzed::Api::V1::Client.new(
      target: 'localhost:50051',
      credentials: :this_channel_is_insecure,
      interceptors: [Authzed::GrpcUtil::BearerToken.new(token: unique_token)]
    )
  end

  context 'with an empty database', :with_unique_tokens do
    it 'writes the schema' do
      client.schema_service.write_schema(
        Authzed::Api::V1::WriteSchemaRequest.new(schema: test_schema)
      )
    end
  end

  context 'with an existing schema', :with_unique_tokens do
    before do
      client.schema_service.write_schema(
        Authzed::Api::V1::WriteSchemaRequest.new(schema: test_schema)
      )
    end

    it 'reads the schema' do
      resp = client.schema_service.read_schema(
        Authzed::Api::V1::ReadSchemaRequest.new
      )
      expect(resp.schema_text).to eq test_schema
    end
  end
end

describe 'Client', '#permissions' do
  context 'with an existing schema', :with_unique_tokens do
    let(:client) do
      Authzed::Api::V1::Client.new(
        target: 'localhost:50051',
        credentials: :this_channel_is_insecure,
        interceptors: [Authzed::GrpcUtil::BearerToken.new(token: unique_token)]
      )
    end

    before do
      client = Authzed::Api::V1::Client.new(
        target: 'localhost:50051',
        credentials: :this_channel_is_insecure,
        interceptors: [Authzed::GrpcUtil::BearerToken.new(token: unique_token)]
      )
      client.schema_service.write_schema(
        Authzed::Api::V1::WriteSchemaRequest.new(schema: test_schema)
      )
    end

    it 'can read and write a relationship' do
      resp = client.permissions_service.read_relationships(
        Authzed::Api::V1::ReadRelationshipsRequest.new(
          consistency: Authzed::Api::V1::Consistency.new(fully_consistent: true),
          relationship_filter: Authzed::Api::V1::RelationshipFilter.new(resource_type: 'document')
        )
      )
      expect(resp.count).to eq 0

      resp = client.permissions_service.write_relationships(
        Authzed::Api::V1::WriteRelationshipsRequest.new(
          updates: [
            Authzed::Api::V1::RelationshipUpdate.new(
              operation: Authzed::Api::V1::RelationshipUpdate::Operation::OPERATION_CREATE,
              relationship: Authzed::Api::V1::Relationship.new(
                resource: Authzed::Api::V1::ObjectReference.new(object_type: 'document', object_id: '1'),
                relation: 'reader',
                subject: Authzed::Api::V1::SubjectReference.new(
                  object: Authzed::Api::V1::ObjectReference.new(object_type: 'user', object_id: 'sam')
                )
              )
            )
          ]
        )
      )
      expect(resp.written_at.token).not_to be_nil

      resp = client.permissions_service.read_relationships(
        Authzed::Api::V1::ReadRelationshipsRequest.new(
          consistency: Authzed::Api::V1::Consistency.new(fully_consistent: true),
          relationship_filter: Authzed::Api::V1::RelationshipFilter.new(resource_type: 'document')
        )
      )
      expect(resp.count).to eq 1
    end

    context 'with existing relationships' do
      let(:emilia) do
        Authzed::Api::V1::SubjectReference.new(
          object: Authzed::Api::V1::ObjectReference.new(object_type: 'user', object_id: 'emilia')
        )
      end
      let(:beatrice) do
        Authzed::Api::V1::SubjectReference.new(
          object: Authzed::Api::V1::ObjectReference.new(object_type: 'user', object_id: 'beatrice')
        )
      end
      let(:document_resource) do
        Authzed::Api::V1::ObjectReference.new(object_type: 'document', object_id: '1')
      end
      let(:write_relationship_request) do
        Authzed::Api::V1::WriteRelationshipsRequest.new(
          updates: [
            Authzed::Api::V1::RelationshipUpdate.new(
              operation: Authzed::Api::V1::RelationshipUpdate::Operation::OPERATION_CREATE,
              relationship: Authzed::Api::V1::Relationship.new(
                resource: document_resource,
                relation: 'writer',
                subject: emilia
              )
            ),
            Authzed::Api::V1::RelationshipUpdate.new(
              operation: Authzed::Api::V1::RelationshipUpdate::Operation::OPERATION_CREATE,
              relationship: Authzed::Api::V1::Relationship.new(
                resource: document_resource,
                relation: 'reader',
                subject: beatrice
              )
            )
          ]
        )
      end
      let(:zed_token) do
        client.permissions_service.write_relationships(write_relationship_request).written_at.token
      end

      it 'can check permissions' do
        resp = client.permissions_service.check_permission(
          Authzed::Api::V1::CheckPermissionRequest.new(
            consistency: Authzed::Api::V1::Consistency.new(
              at_least_as_fresh: Authzed::Api::V1::ZedToken.new(token: zed_token)
            ),
            resource: document_resource,
            permission: 'view',
            subject: emilia
          )
        )
        expect(Authzed::Api::V1::CheckPermissionResponse::Permissionship.resolve(resp.permissionship)).to eq(
          Authzed::Api::V1::CheckPermissionResponse::Permissionship::PERMISSIONSHIP_HAS_PERMISSION
        )

        resp = client.permissions_service.check_permission(
          Authzed::Api::V1::CheckPermissionRequest.new(
            consistency: Authzed::Api::V1::Consistency.new(
              at_least_as_fresh: Authzed::Api::V1::ZedToken.new(token: zed_token)
            ),
            resource: document_resource,
            permission: 'edit',
            subject: beatrice
          )
        )
        expect(Authzed::Api::V1::CheckPermissionResponse::Permissionship.resolve(resp.permissionship)).to eq(
          Authzed::Api::V1::CheckPermissionResponse::Permissionship::PERMISSIONSHIP_NO_PERMISSION
        )
      end
      it 'can bulk-check permissions' do
        resp = client.permissions_service.check_bulk_permissions(
          Authzed::Api::V1::CheckBulkPermissionsRequest.new(
            consistency: Authzed::Api::V1::Consistency.new(
              at_least_as_fresh: Authzed::Api::V1::ZedToken.new(token: zed_token)
            ),
            items: [
              Authzed::Api::V1::CheckBulkPermissionsRequestItem.new(
                resource: document_resource,
                permission: 'view',
                subject: beatrice
              ),
              Authzed::Api::V1::CheckBulkPermissionsRequestItem.new(
                resource: document_resource,
                permission: 'edit',
                subject: beatrice
              )
            ]
          )
        )
        view_response = resp.pairs[0].item
        edit_response = resp.pairs[1].item
        expect(Authzed::Api::V1::CheckPermissionResponse::Permissionship.resolve(view_response.permissionship)).to eq(
          Authzed::Api::V1::CheckPermissionResponse::Permissionship::PERMISSIONSHIP_HAS_PERMISSION
        )
        expect(Authzed::Api::V1::CheckPermissionResponse::Permissionship.resolve(edit_response.permissionship)).to eq(
          Authzed::Api::V1::CheckPermissionResponse::Permissionship::PERMISSIONSHIP_NO_PERMISSION
        )
      end
    end

    context 'when writing a relationship' do
      it 'writes a relationship for issue_creator with a role subject' do
        # Define the relationship to be written
        relationship = Authzed::Api::V1::Relationship.new(
          resource: Authzed::Api::V1::ObjectReference.new(
            object_type: 'project',
            object_id: 'oursoftware'
          ),
          relation: 'issue_creator',
          subject: Authzed::Api::V1::SubjectReference.new(
            object: Authzed::Api::V1::ObjectReference.new(
              object_type: 'role',
              object_id: 'project_manager'
            ),
            optional_relation: 'member'
          )
        )

        # Create a WriteRelationshipsRequest
        request = Authzed::Api::V1::WriteRelationshipsRequest.new(
          updates: [
            Authzed::Api::V1::RelationshipUpdate.new(
              operation: :OPERATION_CREATE,
              relationship: relationship
            )
          ]
        )

        response = client.permissions_service.write_relationships(request)

        expect(response).to be_a(Authzed::Api::V1::WriteRelationshipsResponse)
        expect(response.written_at.token).not_to be_nil

        resp = client.permissions_service.read_relationships(
          Authzed::Api::V1::ReadRelationshipsRequest.new(
            consistency: Authzed::Api::V1::Consistency.new(fully_consistent: true),
            relationship_filter: Authzed::Api::V1::RelationshipFilter.new(resource_type: 'project')
          )
        )
        expect(resp.count).to eq 1
      end
    end
  end
end
