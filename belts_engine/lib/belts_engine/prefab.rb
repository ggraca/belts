module BeltsEngine
  class Prefab
    include Prefab::ComponentMixin

    def self.inherited(subclass)
      super
      subclass.component(:position, Position.zero)
      subclass.component(:rotation, Rotation.identity)
      subclass.component(:scale, Scale.one)
    end
  end
end
