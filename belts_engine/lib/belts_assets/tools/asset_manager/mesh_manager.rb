module BeltsAssets
  module Tools
    class AssetManager
      class MeshManager < BaseManager
        def add_mesh(key, vertices, indices)
          attributes = {
            total_vertices: vertices.size,
            total_indices: indices.size
          }

          @loaders.each do |loader_name, loader_class|
            attributes[loader_name] = loader_class.new(vertices, indices)
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
