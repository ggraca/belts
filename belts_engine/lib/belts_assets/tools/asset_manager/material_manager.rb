module BeltsAssets
  module Tools
    class AssetManager
      class MaterialManager < BaseManager
        def add_material(material)
          raise "Material must have an id" if material.id.nil?
          self[material.id] = material
        end
      end
    end
  end
end
