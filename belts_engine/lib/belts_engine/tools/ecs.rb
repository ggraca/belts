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
        # TODO: Support multiple worlds
        @worlds.first
      end

      def component(name)
        @components[name.to_s]
      end

      def instantiate(prefab, position, rotation, scale)
        entity = Flecs.ecs_entity_init(world, Flecs::EntityDesc.new)
        Flecs.ecs_set_id(world, entity, component(:position), Vec3.size, position)
        Flecs.ecs_set_id(world, entity, component(:rotation), Quat.size, rotation)
        Flecs.ecs_set_id(world, entity, component(:scale), Vec3.size, scale)

        #pp Position.new(Flecs.ecs_get_id(world, entity, @components[0])).to_a
      end

      def destroy(entity)
        Flecs.ecs_delete(world, entity)
      end

      private

      def init_components
        [Position, Rotation, Scale].each do |component|
          name = component.name.underscore
          pp name

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
