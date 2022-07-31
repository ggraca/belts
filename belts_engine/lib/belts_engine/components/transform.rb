Transform = Struct.new(:position, :rotation, :scale, :matrix) do
  def initialize(position: Vec3.zero, rotation: Vec3.zero, scale: Vec3.one)
    super(position, rotation, scale, nil)
    set_matrix
  end

  def move(x, y, z)
    self.position = Vec3[
      position.x + x,
      position.y + y,
      position.z + z
    ]
  end

  def rotate(x, y, z)
    self.rotation = Vec3[
      rotation.x + x,
      rotation.y + y,
      rotation.z + z
    ]
  end

  def position=(val)
    self[:position] = val
    set_matrix
  end

  def rotation=(val)
    self[:rotation] = val
    set_matrix
  end

  def scale=(val)
    self[:scale] = val
    set_matrix
  end

  private

  def set_matrix
    self.matrix =
      Mat4.translation(position) *
      Mat4.rotation(rotation) *
      Mat4.scale(scale)
  end
end
