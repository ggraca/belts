module BeltsEngine::Ecs
  class EntityManager
    def initialize
      @next_id = 0
      @collections = CollectionManager.new
      @entities = {}
    end

    # TODO: Use delegation
    def collection(key)
      @collections.get(key)
    end

    # TODO: Use delegation
    def register_collection(**filters)
      @collections.register(**filters)
    end

    def instantiate(components)
      id = @next_id
      entity = @entities[id] = Entity.new(id)
      @next_id += 1
      entity.merge!(**components)

      @collections.values.each do |collection|
        collection.add_entity(entity)
      end

      id
    end

    def add_components(id, components)
      entity = @entities[id]
      entity.merge!(**components)

      @collections.values.each do |collection|
        collection.add_entity(entity)
      end
    end

    def remove_components(id, keys)
      entity = @entities[id]

      keys.each do |key|
        entity.delete(key)
      end

      @collections.values.each do |collection|
        collection.remove_entity(id)
        collection.add_entity(entity)
      end
    end
  end
end
