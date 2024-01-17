module Vec3Behaviour
  class << self
    def included(base)
      base.layout(:values, [:float, 3])

      [:x, :y, :z].each_with_index do |key, index|
        base.define_method(key) { self[:values][index] }
        base.define_method("#{key}=") { |value| self[:values][index] = value }
      end
    end
  end

  def -@
    self.class.new.tap do |dest|
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

  def as_glm
    GLM::Vec3.new(pointer)
  end

  private

  def scalar_sum(scalar)
    self.class.new.tap do |dest|
      GLM.glmc_vec3_adds(as_glm, scalar, dest.as_glm)
    end
  end

  def vector_sum(vec3)
    self.class.new.tap do |dest|
      GLM.glmc_vec3_add(as_glm, vec3.as_glm, dest.as_glm)
    end
  end

  def scalar_mul(scalar)
    self.class.new.tap do |dest|
      GLM.glmc_vec3_scale(as_glm, scalar, dest.as_glm)
    end
  end

  def vector_mul(vec3)
    self.class.new.tap do |dest|
      GLM.glmc_vec3_mul(as_glm, vec3.as_glm, dest.as_glm)
    end
  end
end
