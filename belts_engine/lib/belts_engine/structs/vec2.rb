class Vec2 < BeltsSupport::Struct
  include Vec2Behaviour

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
