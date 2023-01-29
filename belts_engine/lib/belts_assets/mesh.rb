module BeltsAssets
  class Mesh < Asset
    attr_accessor :vertices, :indices, :material_id, :total_vertices, :total_indices

    def initialize
      @vertices = []
      @indices = []
      @material_id = 0
    end

    def vertices=(value)
      @vertices = value
      @total_vertices = value.size
    end

    def indices=(value)
      @indices = value
      @total_indices = value.size
    end
  end
end
