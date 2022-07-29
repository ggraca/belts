class Vec2
  attr_reader :val

  class << self
    def [](x = 0, y = 0) = new(x, y)

    def zero = Vec2[0, 0]

    def one = Vec2[1, 1]

    def up = Vec2[0, 1]

    def down = Vec2[0, -1]

    def left = Vec2[-1, 0]

    def right = Vec2[1, 0]
  end

  def initialize(x = 0, y = 0)
    @val = Glm::Vec2.new
    @val[:values][0] = x
    @val[:values][1] = y
  end

  def +(other)
    return vector_sum(other) if other.is_a?(Vec2)
    scalar_sum(other)
  end

  def *(other)
    return vector_mul(other) if other.is_a?(Vec2)
    scalar_mul(other)
  end

  def to_s
    to_a.join(", ")
  end

  def to_a
    @val[:values].to_a
  end

  private

  def scalar_sum(scalar)
    dest = Vec2.new
    Glm.glmc_vec2_adds(@val, scalar, dest.val)
    dest
  end

  def vector_sum(vec2)
    dest = Vec2.new
    Glm.glmc_vec2_add(@val, vec2.val, dest.val)
    dest
  end

  def scalar_mul(scalar)
    dest = Vec2.new
    Glm.glmc_vec2_scale(@val, scalar, dest.val)
    dest
  end

  def vector_mul(vec2)
    dest = Vec2.new
    Glm.glmc_vec2_mul(@val, vec2.val, dest.val)
    dest
  end
end
