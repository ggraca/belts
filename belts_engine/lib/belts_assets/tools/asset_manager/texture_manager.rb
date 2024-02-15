module BeltsAssets
  module Tools
    class AssetManager
      class TextureManager < BaseManager
        def add_texture(texture)
          raise "Texture must have an id" if texture.id.nil?
          self[texture.id] = texture
        end
      end
    end
  end
end
