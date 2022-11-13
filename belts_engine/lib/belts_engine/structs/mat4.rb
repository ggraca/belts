class Mat4
  attr_reader :val

  class << self
    def [](*values) = new(values)

    def identity
      Mat4[
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
      ]
    end

    def zero
      Mat4[
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0
      ]
    end

    def translation(vec3)
      dest = Mat4.identity
      GLM.glmc_translate(dest.val, vec3.val)
      dest
    end

    def scale(vec3)
      dest = Mat4.identity
      GLM.glmc_scale(dest.val, vec3.val)
      dest
    end

    def rotation(vec3)
      identity = Mat4.identity
      dest_x = Mat4.zero
      dest_y = Mat4.zero
      dest_z = Mat4.zero
      GLM.glmc_rotate_x(identity.val, vec3.x * Math::PI / 180, dest_x.val)
      GLM.glmc_rotate_y(identity.val, vec3.y * Math::PI / 180, dest_y.val)
      GLM.glmc_rotate_z(identity.val, vec3.z * Math::PI / 180, dest_z.val)

      dest_x * dest_y * dest_z
    end

    def perspective(fovy, aspect, near_val, far_val)
      dest = Mat4.identity
      GLM.glmc_perspective(fovy, aspect, near_val, far_val, dest.val)
      dest
    end
  end

  def initialize(values)
    @val = GLM::Mat4.new
    @val[:values].to_ptr.write_array_of_float(values)
  end

  def to_s
    to_a.join(", ")
  end

  def to_a
    @val[:values].to_a
  end

  def *(other)
    dest = Mat4.identity
    GLM.glmc_mat4_mul(@val, other.val, dest.val)
    dest
  end

  def transpose
    dest = Mat4.identity
    GLM.glmc_mat4_transpose_to(@val, dest.val)
    dest
  end

  def inverse
    dest = Mat4.identity
    GLM.glmc_mat4_inv(@val, dest.val)
    dest
  end

  def marshal_dump
    {}.tap do |result|
      result[:values] = @val[:values].to_a
    end
  end

  def marshal_load(serialized_values)
    @val = GLM::Mat4.new

    (0..15).each do |i|
      @val[:values][i] = serialized_values[i] || 0
    end
  end
end
