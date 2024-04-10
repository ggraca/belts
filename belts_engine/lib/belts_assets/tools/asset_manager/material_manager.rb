module BeltsAssets
  module Tools
    class AssetManager
      class MaterialManager < BaseManager
        def add_material(material)
          raise "Material already exists: #{material.id}" if key?(material.id)

          self[material.id] = material
        end
      end
    end
  end
end
