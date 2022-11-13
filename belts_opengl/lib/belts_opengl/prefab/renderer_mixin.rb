module BeltsOpenGL
  module Prefab
    module RendererMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def renderer(**options)
          set_component(:render_data, RenderData.new(options.slice(:mesh, :color)))
        end
      end
    end
  end
end
