class Mat4  < BeltsSupport::Struct
  include Mat4Behaviour

  class << self
    def [](*values)
      new.tap do |dest|
        dest[:values].to_ptr.write_array_of_float(values)
      end
    end

    def identity
      self[
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
      ]
    end

    def zero
      self[
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0
      ]
    end

    def translation(vec3)
      identity.tap do |dest|
        GLM.glmc_translate(dest.as_glm, vec3.as_glm)
      end
    end

    def scale(vec3)
      identity.tap do |dest|
        GLM.glmc_scale(dest.as_glm, vec3.as_glm)
      end
    end

    def rotation(quat)
      zero.tap do |dest|
        GLM.glmc_quat_mat4(quat.as_glm, dest.as_glm)
      end
    end

    def perspective(fovy, aspect, near_val, far_val)
      identity.tap do |dest|
        GLM.glmc_perspective(fovy, aspect, near_val, far_val, dest.as_glm)
      end
    end

    def look_at(eye, center, up)
      identity.tap do |dest|
        GLM.glmc_lookat(eye.as_glm, center.as_glm, up.as_glm, dest.as_glm)
      end
    end
  end
end
