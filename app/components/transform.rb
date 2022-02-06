Transform = Struct.new(:position, :rotation, :scale) do
  def initialize(position = Vec3.zero, rotation = Vec3.zero, scale = Vec3.one) = super

  def to_matrix
    Mat4.translation(*position) *
      Mat4.rotation(*rotation) *
      Mat4.scale(*scale)
  end
end
