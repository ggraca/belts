module BeltsAssets
  module Tools
    class AssetManager
      class BaseManager < Hash
        def initialize
          @loaders = {}
        end

        def register_loader(key, value)
          @loaders[key] = value
        end
      end
    end
  end
end
