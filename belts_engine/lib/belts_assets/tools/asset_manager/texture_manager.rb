module BeltsAssets
  module Tools
    class AssetManager
      class TextureManager < BaseManager
        def add_texture(texture)
          raise "Texture already exists: #{texture.id}" if key?(texture.id)

          self[texture.id] = texture
        end
      end
    end
  end
end
