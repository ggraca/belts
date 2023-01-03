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
      # model = BeltsAssets::Model.from_file()
      model = BeltsAssets::Model.from_file(key, file_path)

      # model.materials.each { |m| @assets.materials.add(m) }
      # model.meshes.each { |m| @assets.meshes.add(m) }

      model.meshes.each_with_index do |mesh, i|
        @meshes.add_mesh(mesh.id, mesh)
        model.mesh_ids << mesh.id
      end

      # @assets.models.add(model) }
      @models.add_model(key, model)
    end
  end
end
