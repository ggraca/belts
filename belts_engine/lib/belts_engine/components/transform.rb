Transform = Struct.new(:position, :rotation, :scale, :matrix, :flatten_matrix, :flatten_normal_matrix) do
  def initialize(position: Vec3.zero, rotation: Vec3.zero, scale: Vec3.one)
    super(position, rotation, scale, nil, nil, nil)
    set_matrix
  end

  def forward
    Vec3[matrix[0, 2], matrix[1, 2], matrix[2, 2]]
  end

  def right
    Vec3[matrix[0, 0], matrix[1, 0], matrix[2, 0]]
  end

  def up
    Vec3[matrix[0, 1], matrix[1, 1], matrix[2, 1]]
  end

  def back = -forward

  def left = -right

  def down = -up

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

    self.flatten_matrix = matrix.transpose.to_a.flatten.pack("F*")
    self.flatten_normal_matrix = matrix.inverse.to_a.flatten.pack("F*")
  end
end
