module BeltsEngine
  class Scene
    attr_reader :game

    self.instance_eval do
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
        components = Marshal.load(Marshal.dump(prefab[:class_name].components)) # deep copy
        components[:transform].position = prefab[:position] if prefab[:position]
        components[:transform].rotation = prefab[:rotation] if prefab[:rotation]

        @game.entities.instantiate(components)
      end
    end
  end
end
