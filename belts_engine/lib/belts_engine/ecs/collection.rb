module BeltsEngine::Ecs
  class Collection < Hash
    attr_reader :key

    def initialize(with: [], without: [])
      @with = with.sort
      @without = without.sort
      @key = {with: with, without: without}
    end

    def each
      # TODO: implement each without the key
      super
    end

    def each_with_id
      # TODO: implement classic each
      super
    end
  end
end
