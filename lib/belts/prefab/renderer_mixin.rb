module Belts
  class Prefab
    module RendererMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def renderer(type, **options)
          set_component(:render_data, RenderData.new(type, options[:color]))
        end
      end
    end
  end
end
