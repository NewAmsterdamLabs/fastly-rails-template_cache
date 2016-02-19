require "fastly-rails/template_cache/version"
require "fastly-rails/template_cache/bind_methods"
require "fastly-rails/template_cache/template_cache"

if defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i >= 3
  require "fastly-rails/template_cache_rails/template_cache_rails"
  require "fastly-rails/template_cache_rails/engine"
end
