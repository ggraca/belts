module BeltsAssets::Tools
  class AssetManager
    attr_reader :meshes, :models, :materials

    def initialize
      @meshes = MeshManager.new
      @models = ModelManager.new
      @materials = MaterialManager.new
    end

    def reload(config)
      config.models.each do |key, value|
        import_model(key, value[:file])
      end
    end

    private

    def import_model(key, file_path)
      model = BeltsAssets::Model.from_file(key, file_path)

      model.materials.each do |material|
        @materials.add_material(material)
      end

      model.meshes.each do |mesh|
        @meshes.add_mesh(mesh)
      end

      @models.add_model(model)
    end
  end
end
