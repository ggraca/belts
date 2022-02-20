module Belts
  class Prefab
    include Prefab::ComponentMixin
    include Prefab::RendererMixin

    def self.inherited(subclass)
      super
      subclass.component(:transform, Transform.new)
    end
  end
end
