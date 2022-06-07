module BeltsEngine::Ecs
  class EntityManager
    def initialize
      @next_id = 0
      @collections = CollectionManager.new
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
      @collections.each do |key, collection|
        next if (key[:with] - components.keys).any?

        common_keys = key[:with] & components.keys
        collection[@next_id] = components.slice(*common_keys)
      end

      @next_id += 1
    end
  end
end
