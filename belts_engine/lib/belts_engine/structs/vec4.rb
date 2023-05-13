class Vec4
  attr_reader :val

  class << self
    def [](x = 0, y = 0, z = 0, w = 0) = new(x, y, z, w)

    def zero = Vec3[0, 0, 0, 0]

    def one = Vec3[1, 1, 1, 1]
  end

  def initialize(x = 0, y = 0, z = 0, w = 0)
    @val = GLM::Vec4.new
    @val[:values][0] = x
    @val[:values][1] = y
    @val[:values][2] = z
    @val[:values][3] = w
  end

  def x = @val[:values][0]

  def y = @val[:values][1]

  def z = @val[:values][2]

  def w = @val[:values][3]

  def to_s
    to_a.join(", ")
  end

  def to_a
    @val[:values].to_a
  end

  def marshal_dump
    {}.tap do |result|
      result[:x] = @val[:values][0]
      result[:y] = @val[:values][1]
      result[:z] = @val[:values][2]
      result[:w] = @val[:values][3]
    end
  end

  def marshal_load(serialized_values)
    @val = GLM::Vec4.new
    @val[:values][0] = serialized_values[:x]
    @val[:values][1] = serialized_values[:y]
    @val[:values][2] = serialized_values[:z]
    @val[:values][3] = serialized_values[:w]
  end
end
