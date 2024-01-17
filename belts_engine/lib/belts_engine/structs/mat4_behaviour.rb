module Mat4Behaviour
  class << self
    def included(base)
      base.layout(:values, [:float, 16])
    end
  end

  def *(other)
    Mat4.identity.tap do |dest|
      GLM.glmc_mat4_mul(as_glm, other.as_glm, dest.as_glm)
    end
  end

  def transpose
    Mat4.identity.tap do |dest|
      GLM.glmc_mat4_transpose_to(as_glm, dest.as_glm)
    end
  end

  def inverse
    Mat4.identity.tap do |dest|
      GLM.glmc_mat4_inv(as_glm, dest.as_glm)
    end
  end

  def as_glm
    GLM::Mat4.new(pointer)
  end
end
