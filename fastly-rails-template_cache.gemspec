# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastly-rails/template_cache/version'

Gem::Specification.new do |spec|
  spec.name          = "fastly-rails-template_cache"
  spec.version       = FastlyRails::TemplateCache::VERSION
  spec.authors       = ["Borrowed & Blue"]
  spec.email         = ["hello@borrowedandblue.com"]

  spec.summary       = %q{Add rendered templates to Surrogate-Key header for Fastly.}
  spec.description   = %q{Keep track of which templates were rendered for each cached page in Fastly.}
  spec.homepage      = "https://github.com/borrowedandblue/fastly-rails-template_cache"
  spec.license       = "MIT"

  # TODO: Determine what to add here
  ## Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  ## delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "request_store", "~> 1.2"
  spec.add_dependency "fastly-rails", "~> 0.4.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
