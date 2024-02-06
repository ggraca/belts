module BeltsAssets
  class Mesh < Asset
    attr_accessor :indices, :material_id, :positions, :normals, :tangents, :bitangents, :colors

    def initialize
      @indices = []
      @positions = []
      @normals = []
      @tangents = []
      @bitangents = []
      @colors = []
      @material_id = 0
    end

    def vertices
      Array.new(@positions.size) do |i|
        [*positions[i], *normals[i], *colors[i]]
      end.flatten
    end
  end
end
