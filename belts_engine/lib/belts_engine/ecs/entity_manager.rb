module BeltsEngine::Ecs
  class EntityManager < Hash
    def initialize(game)
      @game = game
      @next_id = 0
    end

    def add_components(id, components)
      entity = self[id]
      entity.merge!(**components)

      @game.collections.values.each do |collection|
        collection.add_entity(entity)
      end
    end

    def remove_components(id, keys)
      entity = self[id]

      keys.each do |key|
        entity.delete(key)
      end

      @game.collections.values.each do |collection|
        collection.remove_entity(id)
        collection.add_entity(entity)
      end
    end

    def destroy(id)
      @game.collections.values.each do |collection|
        collection.remove_entity(id)
      end

      delete(id)
    end

    def destroy_all
      keys.each do |id|
        destroy(id)
      end
    end
  end
end
