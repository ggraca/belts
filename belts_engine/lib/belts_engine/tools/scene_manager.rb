module BeltsEngine::Tools
  class SceneManager
    attr_reader :current_scene

    def initialize(game)
      @game = game
      @current_scene = nil
    end

    def unload_scene
      @game.entities.destroy_all
    end

    def load_scene(scene_class)
      unload_scene
      @current_scene = scene_class.new(@game)
    end
  end
end
