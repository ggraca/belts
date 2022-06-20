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
      @@prefabs.each do |prefab|
        @game.entities.instantiate(prefab[:class_name], prefab[:position], prefab[:rotation], prefab[:scale])
      end
    end
  end
end
