module BeltsEngine::Ecs
  class Query
    attr_reader :flecs_query

    def initialize(flecs_query)
      @flecs_query = flecs_query
    end

    def q
      flecs_query
    end

    def each_with_components
      each do |k, v|
        yield(**v)
      end
    end
  end
end
