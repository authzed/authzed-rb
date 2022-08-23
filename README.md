# Authzed Ruby Client

[![Ruby Gems](https://img.shields.io/gem/v/authzed?include_prereleases)](https://rubygems.org/gems/authzed)
[![Docs](https://img.shields.io/badge/docs-authzed.com-%234B4B6C "Authzed Documentation")](https://docs.authzed.com)
[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Build Status](https://github.com/authzed/authzed-rb/workflows/build/badge.svg)](https://github.com/authzed/authzed-rb/actions)
[![Discord Server](https://img.shields.io/discord/844600078504951838?color=7289da&logo=discord "Discord Server")](https://discord.gg/jTysUaxXzM)
[![Twitter](https://img.shields.io/twitter/follow/authzed?color=%23179CF0&logo=twitter&style=flat-square)](https://twitter.com/authzed)

This repository houses the official Ruby client library for Authzed and SpiceDB.

[SpiceDB] is a database system for managing security-critical permissions checking.

SpiceDB acts as a centralized service that stores authorization data.
Once stored, data can be performantly queried to answer questions such as "Does this user have access to this resource?" and "What are all the resources this user has access to?".

[Authzed] operates the globally available, serverless database platform for SpiceDB.

Supported client API versions:
- [v1](https://buf.build/authzed/api/docs/main/authzed.api.v1)
- [v1alpha1](https://buf.build/authzed/api/docs/main/authzed.api.v1alpha1)

You can find more info about the API in the [Authzed Documentation API Reference] or the [Authzed API Buf Registry repository].

See [CONTRIBUTING.md] for instructions on how to contribute and perform common tasks like building the project and running tests.

[SpiceDB]: https://github.com/authzed/spicedb
[Authzed]: https://authzed.com
[Authzed Documentation API Reference]: https://docs.authzed.com/reference/api
[Authzed API Buf Registry repository]: https://buf.build/authzed/api
[CONTRIBUTING.md]: CONTRIBUTING.md
[Discord]: https://authzed.com/discord
[Urgent]: https://github.com/authzed/authzed-rb/labels/priority%2F0%20urgent
[High]: https://github.com/authzed/authzed-rb/labels/priority%2F1%20high
[Medium]: https://github.com/authzed/authzed-rb/labels/priority%2F2%20medium
[Low]: https://github.com/authzed/authzed-rb/labels/priority%2F3%20low
[Maybe]: https://github.com/authzed/authzed-rb/labels/priority%2F4%20maybe
[good first issues]: https://github.com/authzed-rb/spicedb/labels/hint%2Fgood%20first%20issue

## Getting Started

We highly recommend following the **[Protecting Your First App]** guide to learn the latest best practice to integrate an application with Authzed.

If you're interested in example uses of the API, see the spec files in the [spec directory].

[Protecting Your First App]: https://docs.authzed.com/guides/first-app
[spec directory]: /spec

## Basic Usage

### Installation

This project is packaged as the gem `authzed` on [Ruby Gems].

The command to install the library is:

```sh
gem install authzed
```

[Ruby Gems]: https://rubygems.org

### Initializing a client

In order to successfully connect, you will have to provide a [Bearer Token] with your own API Token from the [Authzed dashboard] in place of `t_your_token_here_1234567deadbeef` in the following example:

[Bearer Token]: https://datatracker.ietf.org/doc/html/rfc6750#section-2.1
[Authzed Dashboard]: https://app.authzed.com

```rb
require 'authzed'


client = Authzed::Api::V1::Client.new(
    target: "localhost:50051",
    credentials: :this_channel_is_insecure,
    interceptors: [Authzed::GrpcUtil::BearerToken.new(token: "somerandomkeyhere")],
)
```

### Performing an API call

```rb
require 'authzed'

# Is Emilia in the set of users that can read post #1?
resp = client.permissions_service.check_permission(
  Authzed::Api::V1::CheckPermissionRequest.new(
    consistency: Authzed::Api::V1::Consistency.new(
      at_least_as_fresh: Authzed::Api::V1::ZedToken.new(token: zed_token)
    ),
    resource: Authzed::Api::V1::ObjectReference.new(object_type: 'blog/post', object_id: '1'),
    permission: 'read',
    subject: Authzed::Api::V1::SubjectReference.new(
      object: Authzed::Api::V1::ObjectReference.new(object_type: 'blog/user', object_id: 'emilia')
    )
  )
)
can_read = Authzed::Api::V1::CheckPermissionResponse::Permissionship.resolve(resp.permissionship)) ==
  Authzed::Api::V1::CheckPermissionResponse::Permissionship::PERMISSIONSHIP_HAS_PERMISSION
```
