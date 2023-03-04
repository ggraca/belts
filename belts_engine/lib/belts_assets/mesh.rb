module BeltsAssets
  class Mesh < Asset
    attr_accessor :indices, :material_id, :positions, :normals, :colors

    def initialize
      @indices = []
      @positions = []
      @normals = []
      @colors = []
      @material_id = 0
    end

    def vertices
      @positions.size.times.map do |i|
        [*positions[i], *normals[i], *colors[i]]
      end.flatten
    end
  end
end
