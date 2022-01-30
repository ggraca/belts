class Meshes::Square < Mesh
  def initialize
    vertices = [
      -HU, HU, 0, *Float3.back.values,
      -HU, -HU, 0, *Float3.back.values,
      HU, -HU, 0, *Float3.back.values,
      HU, HU, 0, *Float3.back.values
    ]

    indexes = [
      0, 1, 2, 2, 3, 0
    ]

    super(vertices, indexes)
  end
end
