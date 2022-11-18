module BeltsEngine::Tools
  class AssetManager
    attr_reader :meshes, :models

    def initialize
      @meshes = MeshManager.new
      @models = ModelManager.new(self)
    end
  end
end
