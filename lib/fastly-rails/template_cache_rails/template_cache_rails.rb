module FastlyRails
  module TemplateCacheRails
    class << self
      def initialize!(app)
        raise "FastlyRails::TemplateCache initialized twice. Set `require: false' for fastly-rails-template_cache in your Gemfile" if @already_initialized

        ActiveSupport.on_load(:action_view) do
          FastlyRails::TemplateCache.bind_to_template_render
        end

        app.middleware.use FastlyRails::TemplateCache::Rack

        @already_initialized = true
      end
    end
  end
end
