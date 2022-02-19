Transform = Struct.new(:position, :rotation, :scale) do
  def initialize(position: Vec3.zero, rotation: Vec3.zero, scale: Vec3.one) = super(position, rotation, scale)

  def to_matrix
    Mat4.translation(*position) *
      Mat4.rotation(*rotation) *
      Mat4.scale(*scale)
  end

  def forward
    matrix = to_matrix
    Vec3[matrix[0, 2], matrix[1, 2], matrix[2, 2]]
  end

  def right
    matrix = to_matrix
    Vec3[matrix[0, 0], matrix[1, 0], matrix[2, 0]]
  end

  def up
    matrix = to_matrix
    Vec3[matrix[0, 1], matrix[1, 1], matrix[2, 1]]
  end

  def back = -forward
  def left = -right
  def down = -up
end
