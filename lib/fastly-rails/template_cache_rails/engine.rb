module FastlyRails
  module TemplateCacheRails
    class Engine < ::Rails::Engine
      initializer "fastly-rails-template_cache.initialize" do |app|
        FastlyRails::TemplateCacheRails.initialize!(app)
      end
    end
  end
end
