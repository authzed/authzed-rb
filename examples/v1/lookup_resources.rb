require 'authzed'

# Initialize the client
client = Authzed::Api::V1::Client.new(
  target: 'grpc.authzed.com:443',
  interceptors: [Authzed::GrpcUtil::BearerToken.new(token: 'mytoken')],
)

# Define the subject (the user we're checking for)
emilia = Authzed::Api::V1::SubjectReference.new(
  object: Authzed::Api::V1::ObjectReference.new(
    object_type: 'blog/user',
    object_id: 'emilia'
  )
)

# Create a LookupResources request to find all posts that emilia can read
request = Authzed::Api::V1::LookupResourcesRequest.new(
  resource_object_type: 'blog/post',
  permission: 'read',
  subject: emilia,
  consistency: Authzed::Api::V1::Consistency.new(
    fully_consistent: true
  )
)

# LookupResources returns a streaming response
# Collect all resource IDs into an array
resources = []

puts "Looking up resources that emilia can read..."

client.permissions_service.lookup_resources(request) do |response|
  # Each response contains one resource ID
  resource_id = response.resource_object_id
  resources << resource_id
  puts "Found resource: #{resource_id}"
end

puts "\nTotal resources found: #{resources.length}"
puts "Resource IDs: #{resources.join(', ')}"

# You can also look up resources with a specific permission
# For example, find all posts that emilia can write
write_request = Authzed::Api::V1::LookupResourcesRequest.new(
  resource_object_type: 'blog/post',
  permission: 'write',
  subject: emilia,
  consistency: Authzed::Api::V1::Consistency.new(
    fully_consistent: true
  )
)

writable_resources = []

puts "\nLooking up resources that emilia can write..."

client.permissions_service.lookup_resources(write_request) do |response|
  resource_id = response.resource_object_id
  writable_resources << resource_id
  puts "Found writable resource: #{resource_id}"
end

puts "\nTotal writable resources found: #{writable_resources.length}"
puts "Writable resource IDs: #{writable_resources.join(', ')}"
