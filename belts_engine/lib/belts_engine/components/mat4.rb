class Mat4
  attr_reader :val

  class << self
    def [](*values) = new(values)

    def translation(vec3)
      dest = Mat4.new([])
      Glm.glmc_translate(dest.val, vec3.val)
      dest
    end

    def scale(vec3)
      dest = Mat4.new([])
      Glm.glmc_scale(dest.val, vec3.val)
      dest
    end

    def rotation(vec3)
      identity = Mat4.new([])
      dest_x = Mat4.new([])
      dest_y = Mat4.new([])
      dest_z = Mat4.new([])
      Glm.glmc_rotate_x(identity.val, vec3.to_a[0] * Math::PI / 180, dest_x.val)
      Glm.glmc_rotate_y(identity.val, vec3.to_a[1] * Math::PI / 180, dest_y.val)
      Glm.glmc_rotate_z(identity.val, vec3.to_a[2] * Math::PI / 180, dest_z.val)

      dest_x * dest_y * dest_z
    end

    def perspective(fovy, aspect, nearVal, farVal)
      dest = Mat4.new([])
      Glm.glmc_perspective(fovy, aspect, nearVal, farVal, dest.val)
      dest
    end
  end

  def initialize(values)
    @val = Glm::Mat4.new

    (0..15).each do |i|
      @val[:values][i] = values[i] || 0
    end
  end

  def to_s
    to_a.join(", ")
  end

  def to_a
    @val[:values].to_a
  end

  def *(other)
    dest = Mat4.new([])
    Glm.glmc_mat4_mul(@val, other.val, dest.val)
    dest
  end

  def transpose
    dest = Mat4.new([])
    Glm.glmc_mat4_transpose_to(@val, dest.val)
    dest
  end

  def inverse
    dest = Mat4.new([])
    Glm.glmc_mat4_inv(@val, dest.val)
    dest
  end

  def marshal_dump
    {}.tap do |result|
      result[:values] = @val[:values].to_a
    end
  end

  def marshal_load(serialized_values)
    @val = Glm::Mat4.new

    (0..15).each do |i|
      @val[:values][i] = serialized_values[i] || 0
    end
  end
end
