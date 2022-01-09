class Meshes::Square < Mesh
  def initialize
    vertices = [
      [-0.5, 0.5, 0.0],
      [0.5, 0.5, 0.0],
      [0.5, -0.5, 0.0],
      [-0.5, -0.5, 0.0]
    ]

    indexes = [
      0, 1, 2, 3
    ]

    super(vertices, indexes)
  end
end
