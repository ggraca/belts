module BeltsEngine::Ecs
  class Query
    def initialize(with: [], without: [])
      @with = with.sort
      @without = without.sort
    end

    def each_with_components
      each do |k, v|
        yield(**v)
      end
    end
  end
end
