class Vec3 < BeltsSupport::Struct
  module Behaviour
    class << self
      def included(base)
        base.layout(:values, [:float, 3])

        [:x, :y, :z].each_with_index do |key, index|
          base.define_method(key) { self[:values][index] }
          base.define_method(:"#{key}=") { |value| self[:values][index] = value }
        end
      end
    end

    def -@
      self.class.new.tap do |dest|
        GLM.glmc_vec3_negate_to(self, dest)
      end
    end

    def +(other)
      return vector_sum(other) if other.is_a?(Vec3::Behaviour)
      scalar_sum(other)
    end

    def *(other)
      return vector_mul(other) if other.is_a?(Vec3::Behaviour)
      scalar_mul(other)
    end

    private

    def scalar_sum(scalar)
      self.class.new.tap do |dest|
        GLM.glmc_vec3_adds(self, scalar, dest)
      end
    end

    def vector_sum(vec3)
      self.class.new.tap do |dest|
        GLM.glmc_vec3_add(self, vec3, dest)
      end
    end

    def scalar_mul(scalar)
      self.class.new.tap do |dest|
        GLM.glmc_vec3_scale(self, scalar, dest)
      end
    end

    def vector_mul(vec3)
      self.class.new.tap do |dest|
        GLM.glmc_vec3_mul(self, vec3, dest)
      end
    end
  end

  include Behaviour

  class << self
    def [](x = 0, y = 0, z = 0)
      dest = new
      dest[:values][0] = x
      dest[:values][1] = y
      dest[:values][2] = z
      dest
    end

    def zero = @_zero ||= self[0, 0, 0].freeze
    def one = @_one ||= self[1, 1, 1].freeze
    def up = @_up ||= self[0, 1, 0].freeze
    def down = @_down ||= self[0, -1, 0].freeze
    def left = @_left ||= self[-1, 0, 0].freeze
    def right = @_right ||= self[1, 0, 0].freeze
    def forward = @_forward ||= self[0, 0, 1].freeze
    def back = @_back ||= self[0, 0, -1].freeze
  end
end
