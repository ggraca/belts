class Vec3 < BeltsSupport::Struct
  include Vec3Behaviour

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
