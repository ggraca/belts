module BeltsEngine::Ecs
  class Query
    def initialize(flecs_query, flecs_world, filters)
      @flecs_query = flecs_query
      @flecs_world = flecs_world

      @fields = filters[:with].map.with_index do |filter, i|
        klass = filter.to_s.camelize.constantize

        {name: filter, klass: klass, size: klass.size, index: i}
      end
    end

    def each_with_components
      it = Flecs.ecs_query_iter(@flecs_world, @flecs_query)
      while(Flecs.ecs_query_next(it))
        pointers = @fields.map do |field_data|
          Flecs.ecs_field_w_size(it, field_data[:size], field_data[:index] + 1)
        end

        it[:count].times.each do |i|
          object = @fields.each_with_object({}) do |field, obj|
            obj[field[:name]] = field[:klass].new(pointers[field[:index]][i * field[:size]])
          end

          yield(**object)
        end
      end
    end
  end
end
