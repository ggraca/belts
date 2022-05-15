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

        def component(name, val)
          set_component(name, val)
        end

        private

        def set_component(name, data)
          @components ||= {}
          @components[name] = data
        end
      end
    end
  end
end
