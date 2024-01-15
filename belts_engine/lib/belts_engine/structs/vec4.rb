class Vec4 < BeltsSupport::Component
  layout :values, [:float, 4]

  class << self
    def [](x = 0, y = 0, z = 0, w = 0) = new(x, y, z, w)

    def zero = Vec3[0, 0, 0, 0]

    def one = Vec3[1, 1, 1, 1]
  end

  def initialize(x = 0, y = 0, z = 0, w = 0)
    self[:values][0] = x
    self[:values][1] = y
    self[:values][2] = z
    self[:values][3] = w
  end

  def x = self[:values][0]

  def y = self[:values][1]

  def z = self[:values][2]

  def w = self[:values][3]

  def to_s
    to_a.join(", ")
  end

  def to_a
    self[:values].to_a
  end

  def marshal_dump
    {}.tap do |dest|
      dest[:x] = self[:values][0]
      dest[:y] = self[:values][1]
      dest[:z] = self[:values][2]
      dest[:w] = self[:values][3]
    end
  end

  def marshal_load(serialized_values)
    Vec4.new.tap do |dest|
      dest[:values][0] = serialized_values[:x]
      dest[:values][1] = serialized_values[:y]
      dest[:values][2] = serialized_values[:z]
      dest[:values][3] = serialized_values[:w]
    end
  end

  def as_glm
    GLM::Vec4.new(pointer)
  end
end
