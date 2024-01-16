class Vec2 < BeltsSupport::Struct
  layout :values, [:float, 2]

  class << self
    def [](x = 0, y = 0)
      Vec2.new.tap do |dest|
        dest[:values][0] = x
        dest[:values][1] = y
      end
    end

    def zero = Vec2[0, 0]

    def one = Vec2[1, 1]

    def up = Vec2[0, 1]

    def down = Vec2[0, -1]

    def left = Vec2[-1, 0]

    def right = Vec2[1, 0]
  end

  def x = self[:values][0]
  def x=(value)
    self[:values][0] = value
  end

  def y = self[:values][1]
  def y=(value)
    self[:values][1] = value
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
    self[:values].to_a
  end

  private

  def scalar_sum(scalar)
    Vec2.new.tap do |dest|
      GLM.glmc_vec2_adds(as_glm, scalar, dest.as_glm)
    end
  end

  def vector_sum(vec2)
    Vec2.new.tap do |dest|
      GLM.glmc_vec2_add(as_glm, vec2.as_glm, dest.as_glm)
    end
  end

  def scalar_mul(scalar)
    Vec2.new.tap do |dest|
      GLM.glmc_vec2_scale(as_glm, scalar, dest.as_glm)
    end
  end

  def vector_mul(vec2)
    Vec2.new.tap do |dest|
      GLM.glmc_vec2_mul(as_glm, vec2.as_glm, dest.as_glm)
    end
  end

  def as_glm
    GLM::Vec2.new(pointer)
  end
end
