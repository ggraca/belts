module BeltsAssets
  module Tools
    class AssetManager
      class MeshManager < BaseManager
        def add_mesh(mesh)
          raise "Mesh already exists: #{mesh.id}" if key?(mesh.id)

          self[mesh.id] = mesh
        end
      end
    end
  end
end
