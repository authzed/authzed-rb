require "authzed"

test_schema = """
/** document represents a document protected by Authzed. */
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

/** user represents a user that can be granted role(s) */
definition user {}
"""

describe "Client", "#schema" do
  context "with an empty database" do
    it "writes the schema" do
      client = Authzed::Api::V1alpha1::Client.new(
        target: "localhost:50051",
        credentials: :this_channel_is_insecure,
        interceptors: [Authzed::GrpcUtil::BearerToken.new(token: "somerandomkeyhere")],
      )

      resp = client.schema_service.write_schema(
        Authzed::Api::V1alpha1::WriteSchemaRequest.new(schema: test_schema)
      )
      expect(resp.object_definitions_names.length).to eq 2
      expect(resp.object_definitions_names).to include "document"
      expect(resp.object_definitions_names).to include "user"
    end
  end
end

describe "Client", "#schema" do
  context "with an existing schema" do
    let(:client) do
      Authzed::Api::V1alpha1::Client.new(
        target: "localhost:50051",
        credentials: :this_channel_is_insecure,
        interceptors: [Authzed::GrpcUtil::BearerToken.new(token: "somerandomkeyhere")],
      )
    end
    let(:v1_client) do
      Authzed::Api::V1::Client.new(
        target: "localhost:50051",
        credentials: :this_channel_is_insecure,
        interceptors: [Authzed::GrpcUtil::BearerToken.new(token: "somerandomkeyhere")],
      )
    end

    before do
      client.schema_service.write_schema(
        Authzed::Api::V1alpha1::WriteSchemaRequest.new(schema: test_schema)
      )
    end

    it "reads the schema" do
      resp = client.schema_service.read_schema(
        Authzed::Api::V1alpha1::ReadSchemaRequest.new(
          object_definitions_names: ['user'],
        )
      )
      expect(resp.object_definitions.length).to eq 1
      expect(resp.object_definitions[0]).to eq "/** user represents a user that can be granted role(s) */\ndefinition user {}"
    end

    it "can write a relationship" do
      resp = v1_client.permissions_service.read_relationships(
        Authzed::Api::V1::ReadRelationshipsRequest.new(
          relationship_filter: Authzed::Api::V1::RelationshipFilter.new(resource_type: 'document')
        )
      )
      expect(resp.count).to eq 0

      resp = v1_client.permissions_service.write_relationships(
        Authzed::Api::V1::WriteRelationshipsRequest.new(
          updates: [
            Authzed::Api::V1::RelationshipUpdate.new(
              operation: Authzed::Api::V1::RelationshipUpdate::Operation::OPERATION_CREATE,
              relationship: Authzed::Api::V1::Relationship.new(
                resource: Authzed::Api::V1::ObjectReference.new(object_type: 'document', object_id: '1'),
                relation: 'writer',
                subject: Authzed::Api::V1::SubjectReference.new(
                  object: Authzed::Api::V1::ObjectReference.new(object_type: 'user', object_id: 'sam'),
                )
              )
            )
          ]
        )
      )
      expect(resp.written_at.token).not_to eq(nil)

      resp = v1_client.permissions_service.read_relationships(
        Authzed::Api::V1::ReadRelationshipsRequest.new(
          relationship_filter: Authzed::Api::V1::RelationshipFilter.new(resource_type: 'document')
        )
      )
      expect(resp.count).to eq 1
    end
  end
end
