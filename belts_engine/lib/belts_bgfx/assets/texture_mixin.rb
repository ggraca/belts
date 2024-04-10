module BeltsBGFX
  module Assets
    module TextureMixin
      def self.included(base)
        base.instance_eval do
          include InstanceMethods
        end
      end

      module InstanceMethods
        def bgfx
          @bgfx ||= BeltsBGFX::Assets::TextureLoader.new(self)
        end
      end
    end
  end
end
