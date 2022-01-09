class Meshes::Cube < Mesh
  U = 0.5 # Unit size

  def initialize
    vertices = [
      # Back face (clockwise winding)
      [-U, U, -U],
      [U, U, -U],
      [U, -U, -U],
      [-U, -U, -U],

      # Front face (counter-clockwise winding)
      [-U, U, U],
      [U, U, U],
      [U, -U, U],
      [-U, -U, U]
    ]

    indexes = [
      0, 1, 2, 2, 3, 0, # Back face
      5, 4, 7, 7, 6, 5, # Front face
      4, 5, 1, 1, 0, 4, # Top face
      3, 2, 6, 6, 7, 3, # Bottom face
      4, 0, 3, 3, 7, 4, # Left face
      1, 5, 6, 6, 2, 1  # Right face
    ]

    super(vertices, indexes)
  end
end
