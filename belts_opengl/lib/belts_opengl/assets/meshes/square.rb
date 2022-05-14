module BeltsOpengl::Assets
  class Meshes::Square < Mesh
    def initialize
      vertices = [
        -HU, HU, 0, *Vec3.back,
        -HU, -HU, 0, *Vec3.back,
        HU, -HU, 0, *Vec3.back,
        HU, HU, 0, *Vec3.back
      ]

      indexes = [
        0, 1, 2, 2, 3, 0
      ]

      super(vertices, indexes)
    end
  end
end
