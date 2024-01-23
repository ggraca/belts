class Mat4  < BeltsSupport::Struct
  include Mat4Behaviour

  class << self
    def [](*values)
      new.tap do |dest|
        dest[:values].to_ptr.write_array_of_float(values)
      end
    end

    def identity
      @_identity ||= new.tap do |dest|
        GLM.glmc_mat4_identity(dest.as_glm)
      end.freeze
    end

    def translation(vec3)
      new.tap do |dest|
        GLM.glmc_translate_make(dest.as_glm, vec3.as_glm)
      end
    end

    def scale(vec3)
      new.tap do |dest|
        GLM.glmc_scale_make(dest.as_glm, vec3.as_glm)
      end
    end

    def rotation(quat)
      new.tap do |dest|
        GLM.glmc_quat_mat4(quat.as_glm, dest.as_glm)
      end
    end

    def perspective(fovy, aspect, near_val, far_val)
      new.tap do |dest|
        GLM.glmc_perspective(fovy, aspect, near_val, far_val, dest.as_glm)
      end
    end

    def look_at(eye, center, up)
      new.tap do |dest|
        GLM.glmc_lookat(eye.as_glm, center.as_glm, up.as_glm, dest.as_glm)
      end
    end
  end
end
