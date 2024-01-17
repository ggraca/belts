module BeltsEngine
  class Prefab
    include Prefab::ComponentMixin

    def self.inherited(subclass)
      super
      # TODO: Perhaps not needed
      subclass.component(:position, Vec3.zero)
      subclass.component(:rotation, Quat.identity)
      subclass.component(:scale, Vec3.one)
    end
  end
end
