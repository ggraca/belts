Transform = Struct.new(:position, :rotation, :scale) do
  def initialize(position = Float3.zero, rotation = Float3.zero, scale = Float3.one) = super
end
