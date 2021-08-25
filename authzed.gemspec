Gem::Specification.new do |s|
  s.name        = 'authzed'
  s.version     = '0.1.0'
  s.licenses    = ['Apache-2.0']
  s.summary     = "Ruby bindings for Authzed API"
  s.description = "Authzed is the best way to build robust and scalable permissions systems. See https://authzed.com for more details."
  s.authors     = ["Authzed"]
  s.email       = 'support@authzed.com'
  s.files       = Dir.glob(%w[LICENSE.txt README.md {exe,lib}/**/*]).reject { |f| File.directory?(f) }
  s.homepage    = 'https://authzed.com'
  s.metadata    = { 
    "bug_tracker_uri" => "https://github.com/authzed/authzed-rb/issues",
    "github_repo"     => "ssh://github.com/authzed/authzed-rb",
    "homepage_uri"    => "https://authzed.com",
    "source_code_uri" => "https://github.com/authzed/authzed-rb",
  }
end
