class Mat4  < BeltsSupport::Struct
  layout :values, [:float, 16]

  class << self
    def [](*values)
      Mat4.new.tap do |dest|
        dest[:values].to_ptr.write_array_of_float(values)
      end
    end

    def identity
      Mat4[
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1
      ]
    end

    def zero
      Mat4[
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0
      ]
    end

    def translation(vec3)
      Mat4.identity.tap do |dest|
        GLM.glmc_translate(dest.as_glm, vec3.as_glm)
      end
    end

    def scale(vec3)
      Mat4.identity.tap do |dest|
        GLM.glmc_scale(dest.as_glm, vec3.as_glm)
      end
    end

    def rotation(quat)
      Mat4.zero.tap do |dest|
        GLM.glmc_quat_mat4(quat.as_glm, dest.as_glm)
      end
    end

    def perspective(fovy, aspect, near_val, far_val)
      Mat4.identity.tap do |dest|
        GLM.glmc_perspective(fovy, aspect, near_val, far_val, dest.as_glm)
      end
    end

    def look_at(eye, center, up)
      Mat4.identity.tap do |dest|
        GLM.glmc_lookat(eye.as_glm, center.as_glm, up.as_glm, dest.as_glm)
      end
    end
  end

  def to_s
    to_a.join(", ")
  end

  def to_a
    self[:values].to_a
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

  def marshal_dump
    {}.tap do |dest|
      dest[:values] = self[:values].to_a
    end
  end

  def marshal_load(serialized_values)
    Mat4.new.tap do |dest|
      (0..15).each do |i|
        dest[:values][i] = serialized_values[i] || 0
      end
    end
  end

  def as_glm
    GLM::Mat4.new(pointer)
  end
end
