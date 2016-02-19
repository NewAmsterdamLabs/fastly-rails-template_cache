require "template_cache/version"
require "template_cache/listener"

if defined?(::Rails) && ::Rails::VERSION::MAJOR.to_i >= 3
  require "template_cache/engine"
end
