Transform = Struct.new(:position, :rotation, :scale) do
  def initialize(position = Float3.zero, rotation = Float3.zero, scale = Float3.one) = super

  def to_matrix
    Mat4.translation(*position.values) *
      Mat4.rotation(*rotation.values) *
      Mat4.scale(*scale.values)
  end
end
