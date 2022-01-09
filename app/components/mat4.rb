Mat4 = Struct.new(:m) do
  class << self
    def identity = Matrix.identity(4)
    def translation(x, y, z)
      Matrix[
        [1, 0, 0, x],
        [0, 1, 0, y],
        [0, 0, 1, z],
        [0, 0, 0, 1]
      ]
    end
    def scale(x, y, z)
      Matrix[
        [x, 0, 0, 0],
        [0, y, 0, 0],
        [0, 0, z, 0],
        [0, 0, 0, 1]
      ]
    end
    def perspective(fov, aspect, near, far)
      x_scale = 1.0 / Math.tan(fov * Math::PI / 360.0)
      y_scale = x_scale / aspect
      nearmfar = near - far

      Matrix[
        [x_scale, 0, 0, 0],
        [0, y_scale, 0, 0],
        [0, 0, (far + near) / nearmfar, -1],
        [0, 0, 2 * far * near / nearmfar, 0]
      ]
    end
  end
end
