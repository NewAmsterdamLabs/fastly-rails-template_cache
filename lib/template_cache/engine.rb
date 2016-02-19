module FastlyRails
  module TemplateCache
    class Engine < ::Rails::Engine
      initializer "fastly-rails-template_cache.initialize" do |app|
        FastlyRails::TemplateCache::Listener.initialize!(app)
      end
    end
  end
end
