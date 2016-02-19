module FastlyRails
  class TemplateCache
    module BindMethods
      def bind_to_template_render
        klass = ActionView::Template
        method = "render"

        without_listening = "#{method}_without_template_listener".to_sym
        with_listening =    "#{method}_with_template_listener".to_sym

        klass.send :alias_method, without_listening, method
        klass.send :define_method, with_listening do |*args, &orig|
          name = @identifier.split('app/views/').last
          FastlyRails::TemplateCache.add_template(name)
          result = self.send without_listening, *args, &orig
          result
        end

        klass.send :alias_method, method, with_listening
      end

      def unbind_from_template_render
        klass = ActionView::Template
        method = "render"

        without_listening = "#{method}_without_template_listener".to_sym
        with_listening =    "#{method}_with_template_listener".to_sym

        if klass.send :method_defined?, with_listening
          klass.send :alias_method, method, without_listening
          klass.send :remove_method, with_listening
          klass.send :remove_method, without_listening
        end
      end
    end
  end
end
