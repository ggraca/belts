class Meshes::Square < Mesh
  def initialize
    vertices = [
      [-0.5, 0.5, 0.0],
      [0.5, 0.5, 0.0],
      [0.5, -0.5, 0.0],
      [0.5, -0.5, 0.0],
      [-0.5, -0.5, 0.0],
      [-0.5, 0.5, 0.0]
    ]

    super(vertices)
  end
end
