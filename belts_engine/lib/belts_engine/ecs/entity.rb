module BeltsEngine::Ecs
  class Entity < Hash
    def initialize(id)
      self[:id] = id
    end

    def add_components
      self[name] = value
    end
  end
end
