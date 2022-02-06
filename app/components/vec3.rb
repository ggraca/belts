Vec3 = Struct.new(:x, :y, :z) do
  class << self
    def zero = new(0, 0, 0)
    def one = new(1, 1, 1)
    def up = new(0, 1, 0)
    def down = new(0, -1, 0)
    def left = new(-1, 0, 0)
    def right = new(1, 0, 0)
    def forward = new(0, 0, 1)
    def back = new(0, 0, -1)
  end

  def initialize(x = 0, y = 0, z = 0) = super
  def *(number) = Vec3.new(x * number, y * number, z * number)
end
