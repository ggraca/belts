module BeltsEngine
  class Scene
    attr_reader :game

    instance_eval do
      extend Module.new {
        def prefab(class_name, **options)
          @@prefabs ||= []
          @@prefabs << options.merge(class_name: class_name)
        end
      }
    end

    def initialize(game)
      @game = game
      init_entities
    end

    private

    def init_entities
      pp @@prefabs.last[:position][:values].to_a
      pp @@prefabs.last[:scale][:values].to_a

      @@prefabs.each do |prefab|
        position = prefab[:position] || Vec3.zero
        rotation = prefab[:rotation] || Quat.identity
        scale = prefab[:scale] || Vec3.one

        @game.entities.instantiate(prefab[:class_name], position, rotation, scale)

        @game.ecs.instantiate(
          prefab[:class_name],
          Position.new.tap do |dest|
            dest.set!(position)
          end,
          Rotation.new.tap do |dest|
            dest.set!(rotation)
          end,
          Scale.new.tap do |dest|
            dest.set!(scale)
          end
        )
      end
    end
  end
end
