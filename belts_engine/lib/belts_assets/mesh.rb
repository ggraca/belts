module BeltsAssets
  class Mesh < Asset
    class << self
      # NOTE: this is a quad pointing towards the negative z-axis
      def sprite_mesh(key)
        new(key).tap do |mesh|
          mesh.total_vertices = 4
          mesh.total_elements = 6

          mesh.positions = [
            [-0.5, 0.5, 0.0],
            [0.5, 0.5, 0.0],
            [0.5, -0.5, 0.0],
            [-0.5, -0.5, 0.0]
          ]

          mesh.texture_coords = [
            [0.0, 0.0],
            [1.0, 0.0],
            [1.0, 1.0],
            [0.0, 1.0]
          ]

          mesh.indices = [
            0, 1, 2,
            2, 3, 0
          ]
        end
      end
    end

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
