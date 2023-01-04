module BeltsAssets::Tools
  class AssetManager
    attr_reader :meshes, :models

    def initialize
      @meshes = MeshManager.new
      @models = ModelManager.new
    end

    def reload(config)
      config.models.each do |key, value|
        import_model(key, value[:file])
      end
    end

    private

    def import_model(key, file_path)
      model = BeltsAssets::Model.from_file(key, file_path)

      # model.materials.each { |m| @assets.materials.add(m) }
      # model.meshes.each { |m| @assets.meshes.add(m) }

      model.meshes.each do |mesh|
        @meshes.add_mesh(mesh)
      end

      # @assets.models.add(model) }
      @models.add_model(model)
    end
  end
end
