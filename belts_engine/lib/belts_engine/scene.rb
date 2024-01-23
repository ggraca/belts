module BeltsEngine
  class Scene
    class << self
      def prefabs
        @prefabs ||= []
      end

      def prefab(class_name, **options)
        prefabs << options.merge(class_name: class_name)
      end
    end

    def initialize(game)
      @game = game
      init_entities
    end

    private

    def init_entities
      self.class.prefabs.each do |prefab|
        position = prefab[:position] || Vec3.zero
        rotation = prefab[:rotation] || Quat.identity
        scale = prefab[:scale] || Vec3.one

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
