module BeltsOpenGL::Assets
  class Meshes::Triangle < Mesh
    def initialize
      vertices = [
        0, HU, 0,
        -HU, -HU, 0,
        HU, -HU, 0
      ]

      indexes = [
        0, 1, 2
      ]

      super(vertices, indexes)
    end
  end
end
