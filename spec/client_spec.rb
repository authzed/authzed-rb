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
      client = Authzed::Api::V1::Client.new(
        target: "localhost:50051",
        credentials: :this_channel_is_insecure,
        interceptors: [Authzed::GrpcUtil::BearerToken.new(token: "somerandomkeyhere")],
      )

      resp = client.schema_service.write_schema(
        Authzed::Api::V1::WriteSchemaRequest.new(schema: test_schema)
      )
      expect(resp.object_definitions_names.length).to eq 2
      expect(resp.object_definitions_names).to include "document"
      expect(resp.object_definitions_names).to include "user"
    end
  end
end

describe "Client", "#schema" do
  context "with an existing schema" do
    it "reads the schema" do
      client = Authzed::Api::V1::Client.new(
        target: "localhost:50051",
        credentials: :this_channel_is_insecure,
        interceptors: [Authzed::GrpcUtil::BearerToken.new(token: "somerandomkeyhere")],
      )
      client.schema_service.write_schema(
        Authzed::Api::V1::WriteSchemaRequest.new(schema: test_schema)
      )

      resp = client.schema_service.read_schema(
        Authzed::Api::V1::ReadSchemaRequest.new(
          object_definitions_names: ['user'],
        )
      )
      expect(resp.object_definitions.length).to eq 1
      expect(resp.object_definitions[0]).to eq "/** user represents a user that can be granted role(s) */\ndefinition user {}"
    end
  end
end
