class Vec4 < BeltsSupport::Struct
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
  end

  include Behaviour

  class << self
    def [](x = 0, y = 0, z = 0, w = 0)
      new.tap do |dest|
        dest[:values][0] = x
        dest[:values][1] = y
        dest[:values][2] = z
        dest[:values][3] = w
      end
    end

    def zero = @_zero ||= self[0, 0, 0, 0].freeze
    def one = @_one ||= self[1, 1, 1, 1].freeze
  end
end
