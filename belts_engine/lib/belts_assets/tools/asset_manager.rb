module BeltsAssets::Tools
  class AssetManager
    attr_reader :meshes, :models

    def initialize
      @meshes = MeshManager.new
      @models = ModelManager.new(self)
    end

    def reload(config)
      config.models.each do |key, value|
        @models.add_model(key, value[:file])
      end
    end
  end
end
