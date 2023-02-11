Transform = Struct.new(:position, :rotation, :scale) do
  def initialize(position: Vec3.zero, rotation: Quat.identity, scale: Vec3.one)
    super(position, rotation, scale)
  end

  def move(x, y, z)
    self.position += Vec3[x, y, z]
  end

  def rotate(x, y, z)
    self.rotation *= Quat.from_euler(x, y, z)
  end

  def matrix
    Mat4.translation(position) *
      Mat4.rotation(rotation) *
      Mat4.scale(scale)
  end

  def forward
    rotation * Vec3.forward
  end
end
