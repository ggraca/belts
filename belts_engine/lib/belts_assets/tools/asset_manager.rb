module BeltsAssets::Tools
  class AssetManager
    attr_reader :models, :meshes, :materials, :textures

    def initialize
      @models = ModelManager.new
      @meshes = MeshManager.new
      @materials = MaterialManager.new
      @textures = TextureManager.new

      @textures.add_texture(BeltsAssets::Texture.default_texture)
    end

    def load_sprites(sprites)
      sprites.each do |key, file_name|
        file_path = File.join("assets/textures/", file_name)
        import_sprite(key, file_path)
      end
    end

    def load_models(models)
      models.each do |key, file_name|
        file_path = File.join("assets/models/", file_name)
        import_model(key, file_path)
      end
    end

    private

    def import_sprite(key, file_path)
      data = BeltsAssets::SpriteImporter.new(key, file_path)

      @models.add_model(data.model)
      @textures.add_texture(data.texture)
      @materials.add_material(data.material)
      @meshes.add_mesh(data.mesh)
    end

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
