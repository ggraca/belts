class Quat
  attr_reader :val

  class << self
    def identity
      quat = Quat.new
      GLM::glmc_quat_identity(quat.val)
      quat
    end

    def from_axis_angle(axis, angle)
      quat = Quat.new
      GLM::glmc_quatv(quat.val, angle, axis.val)
      quat
    end

    def from_rotation_x(angle) = from_axis_angle(Vec3.right, angle)
    def from_rotation_y(angle) = from_axis_angle(Vec3.up, angle)
    def from_rotation_z(angle) = from_axis_angle(Vec3.forward, angle)

    def from_euler(x, y, z)
      from_rotation_x(x) * from_rotation_y(y) * from_rotation_z(z)
    end
  end

  def initialize()
    @val = GLM::Quat.new
  end

  def -@
    dest = Quat.new
    GLM.glmc_quat_inv(@val, dest.val)
    dest
  end

  def *(other)
    dest = Quat.new
    GLM.glmc_quat_mul(@val, other.val, dest.val)
    dest
  end

  def marshal_dump
    {}.tap do |result|
      result[:x] = @val[:values][0]
      result[:y] = @val[:values][1]
      result[:z] = @val[:values][2]
      result[:w] = @val[:values][3]
    end
  end

  def marshal_load(serialized_values)
    @val = GLM::Quat.new
    @val[:values][0] = serialized_values[:x]
    @val[:values][1] = serialized_values[:y]
    @val[:values][2] = serialized_values[:z]
    @val[:values][3] = serialized_values[:w]
  end
end
