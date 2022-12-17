module BeltsAssets
  module Tools
    class AssetManager
      class MeshManager < BaseManager
        def add_mesh(key, mesh)
          attributes = {
            total_vertices: mesh.vertices.size,
            total_indices: mesh.indices.size
          }

          @loaders.each do |loader_name, loader_class|
            attributes[loader_name] = loader_class.new(mesh.vertices, mesh.indices)
            attributes[loader_name].load
          end

          self[key] = attributes
        end

        def remove_mesh(key)
          @loaders.each do |loader_name, loader_instance|
            self[key][adaptor_name].unload
          end

          delete(key)
        end
      end
    end
  end
end
