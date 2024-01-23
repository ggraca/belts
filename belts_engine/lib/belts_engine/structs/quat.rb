class Quat < BeltsSupport::Struct
  include QuatBehaviour

  class << self
    def identity
      @_identity ||= new.tap do |dest|
        GLM.glmc_quat_identity(dest.as_glm)
      end.freeze
    end

    def from_axis_angle(axis, angle)
      dest = new
      GLM.glmc_quatv(dest.as_glm, angle, axis.as_glm)
      dest
    end

    def from_rotation_x(angle) = from_axis_angle(Vec3.right, angle)
    def from_rotation_y(angle) = from_axis_angle(Vec3.up, angle)
    def from_rotation_z(angle) = from_axis_angle(Vec3.forward, angle)

    def from_euler(x, y, z)
      from_rotation_x(x) * from_rotation_y(y) * from_rotation_z(z)
    end
  end
end
