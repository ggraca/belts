module BeltsBGFX
  module Assets
    module MeshMixin
      def self.included(base)
        base.instance_eval do
          include InstanceMethods
        end
      end

      module InstanceMethods
        def bgfx
          @bgfx ||= BeltsBGFX::Assets::MeshLoader.new(self)
        end
      end
    end
  end
end
