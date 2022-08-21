class Vec3
  attr_reader :val

  class << self
    def [](x = 0, y = 0, z = 0) = new(x, y, z)

    def zero = Vec3[0, 0, 0]

    def one = Vec3[1, 1, 1]

    def up = Vec3[0, 1, 0]

    def down = Vec3[0, -1, 0]

    def left = Vec3[-1, 0, 0]

    def right = Vec3[1, 0, 0]

    def forward = Vec3[0, 0, 1]

    def back = Vec3[0, 0, -1]
  end

  def initialize(x = 0, y = 0, z = 0)
    @val = Glm::Vec3.new
    @val[:values][0] = x
    @val[:values][1] = y
    @val[:values][2] = z
  end

  def x = @val[:values][0]

  def y = @val[:values][1]

  def z = @val[:values][2]

  def -@
    dest = Vec3.new
    Glm.glmc_vec3_negate_to(@val, dest.val)
    dest
  end

  def +(other)
    return vector_sum(other) if other.is_a?(Vec3)
    scalar_sum(other)
  end

  def *(other)
    return vector_mul(other) if other.is_a?(Vec3)
    scalar_mul(other)
  end

  def to_s
    to_a.join(", ")
  end

  def to_a
    @val[:values].to_a
  end

  def marshal_dump
    {}.tap do |result|
      result[:x] = @val[:values][0]
      result[:y] = @val[:values][1]
      result[:z] = @val[:values][2]
    end
  end

  def marshal_load(serialized_values)
    @val = Glm::Vec3.new
    @val[:values][0] = serialized_values[:x]
    @val[:values][1] = serialized_values[:y]
    @val[:values][2] = serialized_values[:z]
  end

  private

  def scalar_sum(scalar)
    dest = Vec3.new
    Glm.glmc_vec3_adds(@val, scalar, dest.val)
    dest
  end

  def vector_sum(vec3)
    dest = Vec3.new
    Glm.glmc_vec3_add(@val, vec3.val, dest.val)
    dest
  end

  def scalar_mul(scalar)
    dest = Vec3.new
    Glm.glmc_vec3_scale(@val, scalar, dest.val)
    dest
  end

  def vector_mul(vec3)
    dest = Vec3.new
    Glm.glmc_vec3_mul(@val, vec3.val, dest.val)
    dest
  end
end
