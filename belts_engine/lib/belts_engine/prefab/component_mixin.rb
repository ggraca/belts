module BeltsEngine
  class Prefab
    module ComponentMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def components
          @components ||= {}
        end

        def component(name, options = {})
          klass = name.to_s.camelize.constantize
          set_component(name, klass[**options])
        end

        private

        def set_component(name, value)
          @components ||= {}
          @components[name] = value
        end
      end
    end
  end
end
