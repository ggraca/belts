class Meshes::Cube < Mesh
  def initialize
    common_vertices = [
      # Back face
      [-HU, HU, -HU],
      [-HU, -HU, -HU],
      [HU, -HU, -HU],
      [HU, HU, -HU],

      # Front face
      [HU, HU, HU],
      [HU, -HU, HU],
      [-HU, -HU, HU],
      [-HU, HU, HU]
    ]

    vertices = [
      # Back face
      *common_vertices[0], *Vec3.back.values,
      *common_vertices[1], *Vec3.back.values,
      *common_vertices[2], *Vec3.back.values,
      *common_vertices[3], *Vec3.back.values,

      # Right face
      *common_vertices[3], *Vec3.right.values,
      *common_vertices[2], *Vec3.right.values,
      *common_vertices[5], *Vec3.right.values,
      *common_vertices[4], *Vec3.right.values,

      # Front face
      *common_vertices[4], *Vec3.forward.values,
      *common_vertices[5], *Vec3.forward.values,
      *common_vertices[6], *Vec3.forward.values,
      *common_vertices[7], *Vec3.forward.values,

      # Left face
      *common_vertices[7], *Vec3.left.values,
      *common_vertices[6], *Vec3.left.values,
      *common_vertices[1], *Vec3.left.values,
      *common_vertices[0], *Vec3.left.values,

      # Top face
      *common_vertices[7], *Vec3.up.values,
      *common_vertices[0], *Vec3.up.values,
      *common_vertices[3], *Vec3.up.values,
      *common_vertices[4], *Vec3.up.values,

      # Bottom face
      *common_vertices[1], *Vec3.down.values,
      *common_vertices[6], *Vec3.down.values,
      *common_vertices[5], *Vec3.down.values,
      *common_vertices[2], *Vec3.down.values
    ]

    indexes = (0..5).map do |i|
      stride = i * 4

      [
        stride, stride + 1, stride + 2,
        stride + 2, stride + 3, stride
      ]
    end.flatten

    super(vertices, indexes)
  end
end
