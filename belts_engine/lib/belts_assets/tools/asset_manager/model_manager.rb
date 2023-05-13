module BeltsAssets
  module Tools
    class AssetManager
      class ModelManager < Hash
        def add_model(model)
          self[model.id] = model
        end
      end
    end
  end
end
