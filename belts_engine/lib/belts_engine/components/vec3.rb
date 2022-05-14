class Vec3 < Vector
  class << self
    def [](x = 0, y = 0, z = 0) = super(x, y, z)

    def zero = Vec3[0, 0, 0]
    def one = Vec3[1, 1, 1]
    def up = Vec3[0, 1, 0]
    def down = Vec3[0, -1, 0]
    def left = Vec3[-1, 0, 0]
    def right = Vec3[1, 0, 0]
    def forward = Vec3[0, 0, 1]
    def back = Vec3[0, 0, -1]
  end

  def x = self[0]
  def x=(value)
    self[0] = value
  end

  def y = self[1]
  def y=(value)
    self[1] = value
  end

  def z = self[2]
  def z=(value)
    self[2] = value
  end
end
