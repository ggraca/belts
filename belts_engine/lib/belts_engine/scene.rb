module BeltsEngine
  class Scene
    include PrefabsMixin

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
          position.as(Position),
          rotation.as(Rotation),
          scale.as(Scale)
        )
      end
    end
  end
end
