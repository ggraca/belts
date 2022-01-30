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

    def rotation(x, y, z)
      rotation_x = Matrix[
        [1, 0, 0, 0],
        [0, Math.cos(x), -Math.sin(x), 0],
        [0, Math.sin(x), Math.cos(x), 0],
        [0, 0, 0, 1]
      ]

      rotation_y = Matrix[
        [Math.cos(y), 0, Math.sin(y), 0],
        [0, 1, 0, 0],
        [-Math.sin(y), 0, Math.cos(y), 0],
        [0, 0, 0, 1]
      ]

      rotation_z = Matrix[
        [Math.cos(z), -Math.sin(z), 0, 0],
        [Math.sin(z), Math.cos(z), 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
      ]

      rotation_x * rotation_y * rotation_z
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
      y_scale = 1.0 / Math.tan(fov * Math::PI / 360.0)
      x_scale = y_scale / aspect
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
