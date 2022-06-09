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

    def instantiate(prefab_class, position = Vec3.zero, rotation = Vec3.zero, scale = Vec3.one)
      components = Marshal.load(Marshal.dump(prefab_class.to_s.constantize.components)) # deep copy
      components[:transform].position = position if position
      components[:transform].rotation = rotation if rotation

      @game.entities.instantiate(components)
    end

    def add_components(id, components)
      @game.entities.add_components(id, components)
    end

    def remove_components(id, keys)
      @game.entities.remove_components(id, keys)
    end

    private

    def init_entities
      @@prefabs.each do |prefab|
        instantiate(prefab[:class_name], prefab[:position], prefab[:rotation], prefab[:scale])
      end
    end
  end
end
