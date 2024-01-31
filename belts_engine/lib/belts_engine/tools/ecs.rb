module BeltsEngine
  module Tools
    class Ecs
      def initialize(game)
        @worlds = []
        @components = {}
        @phases = {}
        @systems = {}
        @system_ids = {}

        # NOTE: Stored in memory so it doesn't get garbage collected
        @system_callbacks = {}
        @queries = {}
        @game = game

        @worlds << Flecs.ecs_init
        init_components
        init_phases
      end

      def finalize
        @worlds.each do |world|
          Flecs.ecs_fini(world)
        end
      end

      def world
        # TODO: Support multiple worlds?
        @worlds.first
      end

      def component(name)
        id = @components[name.to_s]
        raise "Component #{name} not found" unless id
        id
      end

      def query(filters)
        @queries[filters]
      end

      def add_component(entity, value)
        Flecs.ecs_set_id(world, entity, component(value.class.name.underscore), value.class.size, value)
      end

      def instantiate(prefab_class, position, rotation, scale)
        entity = Flecs.ecs_entity_init(world, Flecs::EntityDesc.new)

        add_component(entity, position)
        add_component(entity, rotation)
        add_component(entity, scale)

        prefab_class.to_s.constantize.components.each do |k, v|
          add_component(entity, v)
        end
      end

      def destroy(entity)
        Flecs.ecs_delete(world, entity)
      end

      def progress
        Flecs.ecs_progress(world, 0)
      end

      def init_systems
        BeltsEngine::System.descendants.each do |sys|
          register_system(sys)
        end
      end

      private

      def init_components
        BeltsSupport::Component.descendants.each do |component|
          name = component.name.underscore

          id = Flecs.ecs_component_init(
            world,
            Flecs::ComponentDesc.new.tap do |desc|
              desc[:type][:name] = FFI::MemoryPointer.from_string(name)
              desc[:type][:size] = component.size
              desc[:type][:alignment] = component.alignment
            end
          )

          @components[name] = id
        end
      end

      def init_phases
        # NOTE: Suggested use cases for each default phase here:
        # https://www.flecs.dev/flecs/md_docs_2DesignWithFlecs.html#phases-and-pipelines

        @phases.merge!(
          on_load: Flecs.EcsOnLoad,
          post_load: Flecs.EcsPostLoad,
          pre_update: Flecs.EcsPreUpdate,
          on_update: Flecs.EcsOnUpdate,
          on_validate: Flecs.EcsOnValidate,
          post_update: Flecs.EcsPostUpdate,
          pre_store: Flecs.EcsPreStore,
          on_store: Flecs.EcsOnStore,
        )
      end

      def register_system(system_class)
        name = system_class.name.underscore

        phase = system_class.pipeline_phase || :on_update
        raise "Phase #{phase} not found" unless @phases[phase]

        @systems[name] = system_class.new(@game)
        @system_callbacks[name] = @systems[name].method(:progress)
        @system_ids[name] = Flecs.ecs_system_init(
          world,
          Flecs::SystemDesc.new.tap do |system|
            system[:entity] = Flecs.ecs_entity_init(
              world,
              Flecs::EntityDesc.new.tap do |entity|
                entity[:add][0] = Flecs.ecs_make_pair(Flecs.EcsDependsOn, @phases[phase])
                entity[:add][1] = @phases[phase]
              end
            )
            system[:callback] = @system_callbacks[name]
          end
        )

        system_class.queries.each do |query_name, filters|
          query = Flecs.ecs_query_init(
            world,
            Flecs::QueryDesc.new.tap do |q|
              filters[:with].each_with_index do |component_name, i|
                q[:filter][:terms][i] = Flecs::Term.new.tap do |t|
                  t[:id] = component(component_name)
                end
              end
            end
          )

          @queries[filters] = BeltsEngine::Ecs::Query.new(query, world, filters)
        end
      end
    end
  end
end
