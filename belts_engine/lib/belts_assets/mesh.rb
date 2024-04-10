module BeltsAssets
  class Mesh < Asset
    attr_accessor :total_vertices, :total_elements
    attr_accessor :indices, :material_id, :positions, :normals, :tangents, :bitangents, :colors, :texture_coords

    def initialize(id)
      super(id)

      @total_vertices = 0
      @total_elements = 0

      @indices = []
      @positions = []
      @normals = []
      @tangents = []
      @bitangents = []
      @texture_coords = []
      @material_id = 0
    end
  end
end
