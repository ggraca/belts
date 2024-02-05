class Vec2 < BeltsSupport::Struct
  module Behaviour
    class << self
      def included(base)
        base.layout(:values, [:float, 2])

        [:x, :y].each_with_index do |key, index|
          base.define_method(key) { self[:values][index] }
          base.define_method("#{key}=") { |value| self[:values][index] = value }
        end
      end
    end

    def +(other)
      return vector_sum(other) if other.is_a?(Vec2::Behaviour)
      scalar_sum(other)
    end

    def *(other)
      return vector_mul(other) if other.is_a?(Vec2::Behaviour)
      scalar_mul(other)
    end

    private

    def scalar_sum(scalar)
      self.class.new.tap do |dest|
        GLM.glmc_vec2_adds(self, scalar, dest)
      end
    end

    def vector_sum(vec2)
      self.class.new.tap do |dest|
        GLM.glmc_vec2_add(self, vec2, dest)
      end
    end

    def scalar_mul(scalar)
      self.class.new.tap do |dest|
        GLM.glmc_vec2_scale(self, scalar, dest)
      end
    end

    def vector_mul(vec2)
      self.class.new.tap do |dest|
        GLM.glmc_vec2_mul(self, vec2, dest)
      end
    end
  end

  include Behaviour

  class << self
    def [](x = 0, y = 0)
      new.tap do |dest|
        dest[:values][0] = x
        dest[:values][1] = y
      end
    end

    def zero = @_zero ||= self[0, 0].freeze
    def one = @_one ||= self[1, 1].freeze
    def up = @_up ||= self[0, 1].freeze
    def down = @_down ||= self[0, -1].freeze
    def left = @_left ||= self[-1, 0].freeze
    def right = @_right ||= self[1, 0].freeze
  end
end
