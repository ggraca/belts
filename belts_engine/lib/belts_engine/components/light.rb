class Light < BeltsSupport::Component
  layout(
    light_type: :ulong,
    r: :float,
    g: :float,
    b: :float
  )

  class << self
    def [](light_type = :point, color = Vec4[1, 1, 1])
      new.tap do |rd|
        rd[:light_type] = light_type.object_id
        rd[:r] = color.x
        rd[:g] = color.y
        rd[:b] = color.z
      end
    end
  end

  def light_type
    ObjectSpace._id2ref(self[:light_type])
  end

  def directional? = light_type == :directional
  def point? = light_type == :point
  def ambient? = light_type == :ambient
end
