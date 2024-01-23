module Mat4Behaviour
  class << self
    def included(base)
      base.layout(:values, [:float, 16])
    end
  end

  def *(other)
    Mat4.identity.tap do |dest|
      GLM.glmc_mat4_mul(self, other, dest)
    end
  end

  def transpose
    Mat4.identity.tap do |dest|
      GLM.glmc_mat4_transpose_to(self, dest)
    end
  end

  def inverse
    Mat4.identity.tap do |dest|
      GLM.glmc_mat4_inv(self, dest)
    end
  end
end
