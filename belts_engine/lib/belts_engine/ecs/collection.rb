module BeltsEngine::Ecs
  class Collection < Hash
    attr_reader :key

    def initialize(with: [], without: [])
      @with = with.sort
      @without = without.sort
      @key = {with: with, without: without}
    end

    def add_entity(entity)
      return if (@with - entity.keys).any?
      return if (@without & entity.keys).any?

      self[entity[:id]] = entity.slice(:id, *@with)
    end

    def remove_entity(entity_id)
      self.delete(entity_id)
    end

    def each_with_components
      each do |k, v|
        yield **v
      end
    end
  end
end
