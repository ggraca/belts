module Vec2Behaviour
  class << self
    def included(base)
      base.layout(:values, [:float, 2])

      [:x, :y].each_with_index do |key, index|
        base.define_method(key) { self[:values][index] }
        base.define_method("#{key}=") { |value| self[:values][index] = value }
      end
    end
  end

  def +(other)
    return vector_sum(other) if other.is_a?(Vec2)
    scalar_sum(other)
  end

  def *(other)
    return vector_mul(other) if other.is_a?(Vec2)
    scalar_mul(other)
  end

  private

  def scalar_sum(scalar)
    self.class.new.tap do |dest|
      GLM.glmc_vec2_adds(self, scalar, dest)
    end
  end

  def vector_sum(vec2)
    self.class.new.tap do |dest|
      GLM.glmc_vec2_add(self, vec2, dest)
    end
  end

  def scalar_mul(scalar)
    self.class.new.tap do |dest|
      GLM.glmc_vec2_scale(self, scalar, dest)
    end
  end

  def vector_mul(vec2)
    self.class.new.tap do |dest|
      GLM.glmc_vec2_mul(self, vec2, dest)
    end
  end
end
