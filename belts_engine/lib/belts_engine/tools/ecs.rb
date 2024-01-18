module BeltsEngine
  module Tools
    class Ecs
      def initialize
        @worlds = []
        @components = {}
        @systems = []

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
    end
  end
end
