module BeltsCore::Systems
  class SceneLoaderSystem < BeltsEngine::System
    phase :pre_update

    def start
      @loaded = false
    end

    def update
      return if @loaded

      main_scene_class = @game.config.main_scene.to_s.constantize
      raise "Main scene not specified" unless main_scene_class

      @game.scenes.load_scene(main_scene_class)
      @loaded = true
    end
  end
end
