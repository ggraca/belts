class Mat4 < BeltsSupport::Struct
  module Behaviour
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

  include Behaviour

  class << self
    def [](*values)
      new.tap do |dest|
        dest[:values].to_ptr.write_array_of_float(values)
      end
    end

    def identity
      @_identity ||= new.tap do |dest|
        GLM.glmc_mat4_identity(dest)
      end.freeze
    end

    def translation(vec3)
      new.tap do |dest|
        GLM.glmc_translate_make(dest, vec3)
      end
    end

    def scale(vec3)
      new.tap do |dest|
        GLM.glmc_scale_make(dest, vec3)
      end
    end

    def rotation(quat)
      new.tap do |dest|
        GLM.glmc_quat_mat4(quat, dest)
      end
    end

    def perspective(fovy, aspect, near_val, far_val)
      new.tap do |dest|
        GLM.glmc_perspective(fovy, aspect, near_val, far_val, dest)
      end
    end

    def look_at(eye, center, up)
      new.tap do |dest|
        GLM.glmc_lookat(eye, center, up, dest)
      end
    end
  end
end
