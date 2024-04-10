module BeltsAssets::Tools
  class AssetManager
    attr_reader :meshes, :models, :materials, :textures

    def initialize
      @models = ModelManager.new
      @meshes = MeshManager.new
      @materials = MaterialManager.new
      @textures = TextureManager.new

      default_texture = BeltsAssets::Texture.new(:default)
      default_texture.width = 1
      default_texture.height = 1
      default_texture.data = "0000"
      @textures.add_texture(default_texture)
    end

    def reload(models)
      models.each do |key, value|
        import_model(key, value)
      end
    end

    private

    def import_model(key, file_path)
      data = BeltsAssets::Importer.new(key, file_path)

      @models.add_model(data.model)

      data.textures.each do |texture|
        @textures.add_texture(texture)
      end

      data.materials.each do |material|
        @materials.add_material(material)
      end

      data.meshes.each do |mesh|
        @meshes.add_mesh(mesh)
      end
    end
  end
end
