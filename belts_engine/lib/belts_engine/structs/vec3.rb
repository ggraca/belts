class Vec3 < BeltsSupport::Struct
  include Vec3Behaviour

  class << self
    def [](x = 0, y = 0, z = 0)
      new.tap do |dest|
        dest[:values][0] = x
        dest[:values][1] = y
        dest[:values][2] = z
      end
    end

    def zero = self[0, 0, 0]
    def one = self[1, 1, 1]
    def up = self[0, 1, 0]
    def down = self[0, -1, 0]
    def left = self[-1, 0, 0]
    def right = self[1, 0, 0]
    def forward = self[0, 0, 1]
    def back = self[0, 0, -1]
  end
end
