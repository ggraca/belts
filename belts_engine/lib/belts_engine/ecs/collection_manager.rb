module BeltsEngine::Ecs
  class CollectionManager < Hash
    def register(**filters)
      collection = Collection.new(**filters)
      self[collection.key] ||= collection
    end

    def get(key)
      raise "Collection not registered: #{key}" unless key?(key)
      self[key]
    end
  end
end
