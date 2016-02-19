require 'request_store'

module FastlyRails
  module TemplateCache
    class Listener
      extend FastlyRails::TemplateCache::BindMethods

      class << self

        def initialize!(app)
          raise "FastlyRails::TemplateCache initialized twice. Set `require: false' for fastly-rails-template_cache in your Gemfile" if @already_initialized

          ActiveSupport.on_load(:action_view) do
            FastlyRails::TemplateCache::Listener.bind_to_template_render
          end

          app.middleware.use FastlyRails::TemplateCache::Rack

          @already_initialized = true
        end

        def templates
          RequestStore.store[:fastly_rails_template_cache_templates]
        end

        def add_template(name)
          RequestStore.store[:fastly_rails_template_cache_templates] << name
        end

        def start
          RequestStore.store[:fastly_rails_template_cache_templates] = []
        end

      end
    end


    class Rack
      def initialize(app)
        @app = app
      end

      def call(env)
        header_key_name = 'Surrogate-Key'
        Listener.start
        status, headers, body = @app.call(env)
        headers[header_key_name] = [headers[header_key_name], *Listener.templates].join(' ') if headers[header_key_name].present?
        [status, headers, body]
      end
    end

  end
end
