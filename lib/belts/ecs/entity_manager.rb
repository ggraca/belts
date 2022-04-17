module Belts::Ecs
  class EntityManager
    def initialize
      @collections = {}

      # TODO: Move this to renderer
      register_collection(with: [:transform, :camera_data])
      register_collection(with: [:transform, :render_data])
    end

    def collection(with: [], without: [])
      key = {with: with.sort, without: without.sort}
      raise "Collection not registered: #{key}" unless @collections.key?(key)

      @collections[key]
    end

    def register_collection(with: [], without: [])
      key = {with: with.sort, without: without.sort}
      @collections[key] = [] # TODO: Avoid duplicates
    end

    def instantiate(components)
      @collections.each do |key, value|
        next if (key[:with] - components.keys).any?

        common_keys = key[:with] & components.keys
        value << components.slice(*common_keys)
      end
    end
  end
end
