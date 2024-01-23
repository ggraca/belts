class Vec4 < BeltsSupport::Struct
  include Vec4Behaviour

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
