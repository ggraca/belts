module QuatBehaviour
  class << self
    def included(base)
      base.layout(:values, [:float, 4])

      [:x, :y, :z, :w].each_with_index do |key, index|
        base.define_method(key) { self[:values][index] }
        base.define_method("#{key}=") { |value| self[:values][index] = value }
      end
    end
  end

  def -@
    Quat.new.tap do |dest|
      GLM.glmc_quat_inv(as_glm, dest.as_glm)
    end
  end

  # TODO: allow this to work with other classes
  def *(other)
    return quat_mul(other) if other.is_a?(Quat)
    return vec3_mul(other) if other.is_a?(Vec3)
    raise ArgumentError, "Can't multiply #{self.class} with #{other.class}"
  end

  def as_glm
    GLM::Quat.new(pointer)
  end

  private

  def quat_mul(other)
    Quat.new.tap do |dest|
      GLM.glmc_quat_mul(as_glm, other.as_glm, dest.as_glm)
    end
  end

  def vec3_mul(other)
    Vec3.new.tap do |dest|
      GLM.glmc_quat_rotatev(as_glm, other.as_glm, dest.as_glm)
    end
  end
end
