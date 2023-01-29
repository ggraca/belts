module BeltsAssets
  module Tools
    class AssetManager
      class MeshManager < BaseManager
        def add_mesh(mesh)
          self[mesh.id] = mesh
          mesh.bgfx.load
        end
      end
    end
  end
end
