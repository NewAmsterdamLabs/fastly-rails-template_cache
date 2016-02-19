require "template_cache/version"
require "template_cache/bind_methods"
require "template_cache/template_cache"

if defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i >= 3
  require "template_cache_rails/template_cache_rails"
  require "template_cache_rails/engine"
end
