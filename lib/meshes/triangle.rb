class Meshes::Triangle < Mesh
  def initialize
    vertices = [
      [-0.6, -0.4, 0.0],
      [0.6, -0.4, 0.0],
      [0.0, 0.6, 0.0]
    ]

    super(vertices)
  end
end
