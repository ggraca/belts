module BeltsAssets
  class Mesh < Asset
    attr_accessor :indices, :material_id, :positions, :normals, :tangents, :bitangents, :colors, :texture_coords

    def initialize
      @indices = []
      @positions = []
      @normals = []
      @tangents = []
      @bitangents = []
      @colors = []
      @texture_coords = []
      @material_id = 0
    end

    def vertices
      Array.new(@positions.size) do |i|
        [*positions[i], *normals[i], *colors[i], *texture_coords[i][0..1]]
      end.flatten
    end
  end
end
