require 'request_store'

module FastlyRails
  class TemplateCache
    extend FastlyRails::TemplateCache::BindMethods

    class << self

      def templates
        RequestStore.store[:fastly_rails_template_cache_templates]
      end

      def add_template(name)
        if RequestStore.store[:fastly_rails_template_cache_templates]
          RequestStore.store[:fastly_rails_template_cache_templates] << name
        end
      end

      def start
        RequestStore.store[:fastly_rails_template_cache_templates] = []
      end

    end


    class Rack
      def initialize(app)
        @app = app
      end

      def call(env)
        FastlyRails::TemplateCache.start

        status, headers, body = @app.call(env)
        header_key_name = 'Surrogate-Key'
        if headers[header_key_name]
          existing_headers = headers[header_key_name]
          template_cache_headers = FastlyRails::TemplateCache.templates
          headers[header_key_name] = [existing_headers, *template_cache_headers].join(' ')
        end

        [status, headers, body]
      end
    end

  end
end
