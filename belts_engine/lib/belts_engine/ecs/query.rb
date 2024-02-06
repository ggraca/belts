module BeltsEngine::Ecs
  class Query
    def initialize(flecs_query, flecs_world, filters)
      @flecs_query = flecs_query
      @flecs_world = flecs_world

      @components = {}
      filters[:with].each.with_index do |name, i|
        klass = name.to_s.camelize.constantize

        @components[name] = {
          name: name,
          klass: klass,
          size: klass.size,
          index: i + 1 # Component indexes start at 1
        }
      end
    end

    def each_with_components(&block)
      params = block.parameters.map(&:last)
      entity_requested = params.include?(:entity)
      components_requested = @components.slice(*params)

      it = Flecs.ecs_query_iter(@flecs_world, @flecs_query)
      while Flecs.ecs_query_next(it)
        components = components_requested.values.map do |component|
          component.merge(pointer: Flecs.ecs_field_w_size(it, component[:size], component[:index]))
        end

        it[:count].times do |i|
          fields = {}

          if entity_requested
            fields[:entity] = it[:entities][i * 8].read_int
          end

          components.each do |component|
            fields[component[:name]] = component[:klass].new(component[:pointer][i * component[:size]])
          end

          yield(**fields)
        end
      end
    end
  end
end
