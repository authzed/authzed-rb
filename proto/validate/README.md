# Generated protoc-gen-validate descriptors

Changes introduced after Ruby protoc changes described in https://protobuf.dev/news/2023-04-20/

The blog post reads

> add_serialized_file verifies that all dependencies listed in the descriptor were previously added with add_serialized_file. Generally that should be fine, because the generated code will contain Ruby require statements for all dependencies, and the descriptor will fail to load anyway if the types depended on were not previously defined in the DescriptorPool.

`protoc-gen-validate` does not offer ruby templates for protoc, so for `authzed-rb` the workaround has been to
generate an empty stub to satisfy the import.

The new Ruby code expects all type descriptors to be loaded, so a warning emerges when a dependency hasn't been loaded:

```
#<Google::Protobuf::TypeError: Unable to build file to DescriptorPool: Depends on file 'validate/validate.proto', but it has not been loaded>

Warning: Protobuf detected an import path issue while loading generated file /usr/local/rvm/gems/ruby-3.1.4/gems/authzed-0.7.0/lib/authzed/api/v1/core_pb.rb
Each proto file must use a consistent fully-qualified name.
This will become an error in the next major version.
```

This folder vendors the `validate.proto` file and generates Ruby code out of it using buf.

## How to generate

```bash
# run from /lib folder
buf generate --template validate/buf.gen.yaml 
```

Note: It's important to run this from /lib, to make sure the generated descriptor name matches `validate/validate.proto`
