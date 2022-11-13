module BeltsEngine::Tools
  class AssetManager
    attr_reader :meshes

    def initialize
      @meshes = MeshManager.new
    end
  end
end
