class Vec3 < BeltsSupport::Struct
  layout :values, [:float, 3]

  class << self
    def [](x = 0, y = 0, z = 0)
      Vec3.new.tap do |dest|
        dest[:values][0] = x
        dest[:values][1] = y
        dest[:values][2] = z
      end
    end

    def zero = Vec3[0, 0, 0]

    def one = Vec3[1, 1, 1]

    def up = Vec3[0, 1, 0]

    def down = Vec3[0, -1, 0]

    def left = Vec3[-1, 0, 0]

    def right = Vec3[1, 0, 0]

    def forward = Vec3[0, 0, 1]

    def back = Vec3[0, 0, -1]
  end

  def x = self[:values][0]
  def x=(value)
    self[:values][0] = value
  end

  def y = self[:values][1]
  def y=(value)
    self[:values][1] = value
  end

  def z = self[:values][2]
  def z=(value)
    self[:values][2] = value
  end

  def -@
    Vec3.new.tap do |dest|
      GLM.glmc_vec3_negate_to(as_glm, dest.as_glm)
    end
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
    self[:values].to_a
  end

  def marshal_dump
    {}.tap do |dest|
      dest[:x] = self[:values][0]
      dest[:y] = self[:values][1]
      dest[:z] = self[:values][2]
    end
  end

  def marshal_load(serialized_values)
    Vec3.new.tap do |dest|
      dest[:values][0] = serialized_values[:x]
      dest[:values][1] = serialized_values[:y]
      dest[:values][2] = serialized_values[:z]
    end
  end

  def as_glm
    GLM::Vec3.new(pointer)
  end

  private

  def scalar_sum(scalar)
    Vec3.new.tap do |dest|
      GLM.glmc_vec3_adds(as_glm, scalar, dest.as_glm)
    end
  end

  def vector_sum(vec3)
    Vec3.new.tap do |dest|
      GLM.glmc_vec3_add(as_glm, vec3.as_glm, dest.as_glm)
    end
  end

  def scalar_mul(scalar)
    Vec3.new.tap do |dest|
      GLM.glmc_vec3_scale(as_glm, scalar, dest.as_glm)
    end
  end

  def vector_mul(vec3)
    Vec3.new.tap do |dest|
      GLM.glmc_vec3_mul(as_glm, vec3.as_glm, dest.as_glm)
    end
  end
end
