module BeltsAssets
  module Tools
    class AssetManager
      class ModelManager < Hash
        def add_model(key, root_node)
          self[key] = root_node
        end
      end
    end
  end
end
