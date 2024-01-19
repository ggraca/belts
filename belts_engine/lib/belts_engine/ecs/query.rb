module BeltsEngine::Ecs
  class Query
    attr_reader :q

    def initialize(q)
      @q = q
    end

    def each_with_components
      each do |k, v|
        yield(**v)
      end
    end
  end
end
