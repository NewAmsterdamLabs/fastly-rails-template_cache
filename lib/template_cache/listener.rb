require 'request_store'

module FastlyRails::TemplateCache
  class Listener
    class << self
      def initialize!(app)
        ActiveSupport.on_load(:action_view) do
          FastlyRails::TemplateCache::Listener.bind_listener_to_render do |x,y|
            return @identifier.split('app/views/').last
          end
        end

        app.middleware.use FastlyRails::TemplateCache::Rack
      end

      def bind_listener_to_render(&block)
        klass = ActionView::Template
        method = "render"
        without_listening = "#{method}_with_template_listener".intern
        with_listening =    "#{method}_without_template_listener".intern

        klass.send :alias_method, without_listening, method
        klass.send :define_method, with_listening do |*args, &orig|
          name = block.bind(self).call(*args)
          FastlyRails::TemplateCache::Listener.add_template(name)
          result = self.send without_listening, *args, &orig
          result
        end

        klass.send :alias_method, method, with_listening
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
      headers[header_key_name] = [headers[header_key_name], *Listener.templates.map(&:to_s)].join(' ') if headers[header_key_name].present?
      [status, headers, body]
    end
  end

end
