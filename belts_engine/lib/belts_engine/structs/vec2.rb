class Vec2 < BeltsSupport::Struct
  include Vec2Behaviour

  class << self
    def [](x = 0, y = 0)
      new.tap do |dest|
        dest[:values][0] = x
        dest[:values][1] = y
      end
    end

    def zero = self[0, 0]
    def one = self[1, 1]
    def up = self[0, 1]
    def down = self[0, -1]
    def left = self[-1, 0]
    def right = self[1, 0]
  end
end
