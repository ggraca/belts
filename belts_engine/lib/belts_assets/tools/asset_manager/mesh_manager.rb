module BeltsAssets
  module Tools
    class AssetManager
      class MeshManager < BaseManager
        def add_mesh(mesh)
          attributes = {
            total_vertices: mesh.vertices.size,
            total_indices: mesh.indices.size
          }

          @loaders.each do |loader_name, loader_class|
            attributes[loader_name] = loader_class.new(mesh.vertices, mesh.indices)
            attributes[loader_name].load
          end

          self[mesh.id] = attributes
        end
      end
    end
  end
end
