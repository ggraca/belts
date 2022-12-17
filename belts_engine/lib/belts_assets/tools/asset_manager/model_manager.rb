module BeltsAssets
  module Tools
    class AssetManager
      class ModelManager < Hash
        def initialize(asset_manager)
          @asset_manager = asset_manager
        end

        def add_model(key, file_path)
          model = { meshes: [] }

          importer = Importer.new(file_path)
          # importer.meshes.each { |mesh| @asset_manager.meshes.add_mesh(mesh) }
          # importer.textures.each { |texture| @asset_manager.textures.add_texture(texture) }
          # importer.materials.each { |material| @asset_manager.materials.add_material(material) }
          # importer.models.each { |model| @asset_manager.models.add_model(model) }

          importer.meshes.each_with_index do |mesh, i|
            mesh_key = "#{key}_mesh_#{i}"
            @asset_manager.meshes.add_mesh(mesh_key, mesh)
            model[:meshes] << mesh_key
          end

          self[key] = model
        end
      end
    end
  end
end
