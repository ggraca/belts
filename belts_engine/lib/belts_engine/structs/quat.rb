class Quat < BeltsSupport::Struct
  module Behaviour
    class << self
      def included(base)
        base.layout(:values, [:float, 4])

        [:x, :y, :z, :w].each_with_index do |key, index|
          base.define_method(key) { self[:values][index] }
          base.define_method(:"#{key}=") { |value| self[:values][index] = value }
        end
      end
    end

    def -@
      Quat.new.tap do |dest|
        GLM.glmc_quat_inv(self, dest)
      end
    end

    # TODO: allow this to work with other classes
    def *(other)
      return quat_mul(other) if other.is_a?(Quat::Behaviour)
      return vec3_mul(other) if other.is_a?(Vec3::Behaviour)
      raise ArgumentError, "Can't multiply #{self.class} with #{other.class}"
    end

    private

    def quat_mul(other)
      dest = Quat.new
      GLM.glmc_quat_mul(self, other, dest)
      dest
    end

    def quat_mul!(other)
      GLM.glmc_quat_mul(self, other, self)
    end

    def vec3_mul(other)
      dest = Vec3.new
      GLM.glmc_quat_rotatev(self, other, dest)
      dest
    end
  end

  include Behaviour

  class << self
    def identity
      @_identity ||= new.tap do |dest|
        GLM.glmc_quat_identity(dest)
      end.freeze
    end

    def from_axis_angle(axis, angle)
      dest = new
      GLM.glmc_quatv(dest, angle, axis)
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
