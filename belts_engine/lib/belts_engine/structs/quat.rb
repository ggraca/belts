class Quat < BeltsSupport::Struct
  layout :values, [:float, 4]

  class << self
    def identity
      Quat.new.tap do |dest|
        GLM.glmc_quat_identity(dest.as_glm)
      end
    end

    def from_axis_angle(axis, angle)
      Quat.new.tap do |dest|
        GLM.glmc_quatv(dest.as_glm, angle, axis.as_glm)
      end
    end

    def from_rotation_x(angle) = from_axis_angle(Vec3.right, angle)
    def from_rotation_y(angle) = from_axis_angle(Vec3.up, angle)
    def from_rotation_z(angle) = from_axis_angle(Vec3.forward, angle)

    def from_euler(x, y, z)
      from_rotation_x(x) * from_rotation_y(y) * from_rotation_z(z)
    end
  end

  def x = self[:values][0]
  def x=(value)
    self[:values][0] = value
  end

  def y = self[:values][1]
  def y=(value)
    self[:values][1] = value
  end

  def z = self[:values][2]
  def z=(value)
    self[:values][2] = value
  end

  def w = self[:values][3]
  def w=(value)
    self[:values][3] = value
  end

  # TODO: Deprecate these methods in favour of the one in Rotation
  def rotate!(x, y, z)
    self.set!(self * Quat.from_euler(x, y, z))
  end

  def forward
    self * Vec3.forward
  end

  def right
    self * Vec3.right
  end
  # TODO: End

  def -@
    Quat.new.tap do |dest|
      GLM.glmc_quat_inv(as_glm, dest.as_glm)
    end
  end

  def *(other)
    return quat_mul(other) if other.is_a?(Quat)
    return vec3_mul(other) if other.is_a?(Vec3)
    raise ArgumentError, "Can't multiply #{self.class} with #{other.class}"
  end

  def marshal_dump
    {}.tap do |dest|
      dest[:x] = self[:values][0]
      dest[:y] = self[:values][1]
      dest[:z] = self[:values][2]
      dest[:w] = self[:values][3]
    end
  end

  def marshal_load(serialized_values)
    Quat.new.tap do |dest|
      dest[:values][0] = serialized_values[:x]
      dest[:values][1] = serialized_values[:y]
      dest[:values][2] = serialized_values[:z]
      dest[:values][3] = serialized_values[:w]
    end
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
