class Light < BeltsSupport::Component
  layout(
    type: :ulong,
    r: :float,
    g: :float,
    b: :float
  )

  class << self
    def [](type: :point, color: Vec4[1, 1, 1])
      new.tap do |rd|
        rd[:type] = type.object_id
        rd[:r] = color.x
        rd[:g] = color.y
        rd[:b] = color.z
      end
    end
  end

  def type
    ObjectSpace._id2ref(self[:type])
  end

  def directional? = type == :directional
  def point? = type == :point
  def ambient? = type == :ambient
end
