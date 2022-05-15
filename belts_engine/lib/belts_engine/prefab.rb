module BeltsEngine
  class Prefab
    include Prefab::ComponentMixin

    def self.inherited(subclass)
      super
      subclass.component(:transform, Transform.new)
    end
  end
end
