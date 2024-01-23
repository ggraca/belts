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
      GLM.glmc_quat_inv(self, dest)
    end
  end

  # TODO: allow this to work with other classes
  def *(other)
    return quat_mul(other) if other.is_a?(Quat)
    return vec3_mul(other) if other.is_a?(Vec3)
    raise ArgumentError, "Can't multiply #{self.class} with #{other.class}"
  end

  private

  def quat_mul(other)
    dest = Quat.new
    GLM.glmc_quat_mul(self, other, dest)
    dest
  end

  def quat_mul!(other)
    GLM.glmc_quat_mul(self, other, self)
  end

  def vec3_mul(other)
    dest = Vec3.new
    GLM.glmc_quat_rotatev(self, other, dest)
    dest
  end
end
