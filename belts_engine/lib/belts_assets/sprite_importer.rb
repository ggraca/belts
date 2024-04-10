require "rmagick"

module BeltsAssets
  class SpriteImporter
    attr_reader :model, :texture, :material, :mesh

    def initialize(key, texture_path)
      @model = Model.new(key)

      @texture = import_texture(texture_path)
      @material = import_material
      @mesh = import_mesh

      @model.root_node = import_node
    end

    private

    def import_texture(texture_path)
      image = Magick::Image.read(texture_path).first

      texture = Texture.new(fetch_texture_id)
      texture.width = image.columns
      texture.height = image.rows
      texture.data = image.export_pixels_to_str(0, 0, image.columns, image.rows, "RGBA")
      texture
    end

    def import_material
      material = Material.new(fetch_material_id)
      material.name = fetch_material_id
      material.texture_ids[:albedo] = fetch_texture_id

      material
    end

    def import_mesh
      mesh = Mesh.sprite_mesh(fetch_mesh_id)
      mesh.name = fetch_mesh_id
      mesh.material_id = fetch_material_id
      mesh
    end

    def import_node
      model_node = ModelNode.new
      model_node.name = "root_node"
      model_node.mesh_ids = [fetch_mesh_id]
      model_node
    end

    def fetch_mesh_id
      :"#{@model.id}_mesh"
    end

    def fetch_material_id
      :"#{@model.id}_material"
    end

    def fetch_texture_id
      :"#{@model.id}_texture"
    end
  end
end
