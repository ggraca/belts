module BeltsEngine
  module Tools
    class Ecs
      def initialize
        @worlds = []
        @components = []
        @systems = []

        @worlds << Flecs.ecs_init
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

      def instantiate(prefab)
        entity = Flecs.ecs_entity_init(world, Flecs::EntityDesc.new)
      end

      def destroy(entity)
        Flecs.ecs_delete(world, entity)
      end
    end
  end
end
