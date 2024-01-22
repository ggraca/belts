module BeltsEngine
  module Tools
    class Ecs
      def initialize(game)
        @worlds = []
        @components = {}
        @systems = {}
        @system_ids = {}
        @system_callbacks = {}
        @queries = {}
        @game = game

        @worlds << Flecs.ecs_init
        init_components
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

      def start_systems
        # TODO: use Flecs.ecs_progress
        @systems.values.each do |sys|
          sys.start
        end
      end

      def progress
        # TODO: use Flecs.ecs_progress
        @system_ids.values.each do |id|
          Flecs.ecs_run(world, id, 0, nil)
        end
      end

      def init_systems
        register_system(BeltsBGFX::Systems::WindowSystem)
        register_system(BeltsBGFX::Systems::RenderSystem)
        register_system(FpsSystem)
        register_system(CameraControllerSystem)
        register_system(SpinnerSystem)

        # BeltsEngine::System.descendants.each do |sys|
        #   register_system(sys)
        # end

        pp @queries
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

      def register_system(system_class)
        name = system_class.name.underscore

        @systems[name] = system_class.new(@game)
        @system_callbacks[name] = @systems[name].method(:update)
        @system_ids[name] = Flecs.ecs_system_init(
          world,
          Flecs::SystemDesc.new.tap do |system|
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

          @queries[filters] = BeltsEngine::Ecs::Query.new(query)
        end
      end
    end
  end
end
