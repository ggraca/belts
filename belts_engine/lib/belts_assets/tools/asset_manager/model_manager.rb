module BeltsAssets
  module Tools
    class AssetManager
      class ModelManager < Hash
        def add_model(model)
          raise "Model already exists: #{model.id}" if key?(model.id)

          self[model.id] = model
        end
      end
    end
  end
end
