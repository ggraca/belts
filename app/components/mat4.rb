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
      x = x * Math::PI / 180
      y = y * Math::PI / 180
      z = z * Math::PI / 180

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
      fov_rad = fov * Math::PI / 180

      f = Math.tan(fov_rad)
      f = 1 / f

      Matrix[
        [f / aspect, 0, 0, 0],
        [0, f, 0, 0],
        [0, 0, (far + near) / (near - far), 2 * far * near / (near - far)],
        [0, 0, -1, 0]
      ]
    end

    def orthographic(left, right, bottom, top, near, far)
      switcher = scale(1, 1, -1)
      scale = scale(2.0 / (right - left), 2.0 / (top - bottom), 2.0 / (far - near))
      centerer = translation(- (right + left) / (right - left), - (top + bottom) / (top - bottom), - (far + near) / (far - near))

      switcher * scale * centerer
    end
  end
end
