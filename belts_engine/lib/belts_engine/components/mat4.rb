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

      y_scale = 1 / Math.tan(fov_rad)
      x_scale = y_scale / aspect
      frustum_length = far - near

      Matrix[
        [x_scale, 0, 0, 0],
        [0, y_scale, 0, 0],
        [0, 0, -(far + near) / frustum_length, -1],
        [0, 0, 2 * -(far * near) / frustum_length, 0]
      ].transpose
    end

    def orthographic(left, right, bottom, top, near, far)
      scale = scale(2.0 / (right - left), 2.0 / (top - bottom), 2.0 / (far - near))
      centerer = translation(- (right + left) / (right - left), - (top + bottom) / (top - bottom), (far - near) / 2.0)
      # inverter = scale(1, 1, -1)

      scale * centerer # * inverter
    end

    def look_at(eye, target, up)
      z_axis = (eye - target).normalize
      x_axis = up.cross(z_axis).normalize
      y_axis = z_axis.cross(x_axis)

      Matrix[
        [x_axis[0], x_axis[1], x_axis[2], -x_axis.dot(eye)],
        [y_axis[0], y_axis[1], y_axis[2], -y_axis.dot(eye)],
        [z_axis[0], z_axis[1], z_axis[2], -z_axis.dot(eye)],
        [0, 0, 0, 1]
      ]
    end
  end
end
