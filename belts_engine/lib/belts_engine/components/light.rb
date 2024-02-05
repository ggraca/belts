class Light < BeltsSupport::Component
  layout(
    light_type: :ulong
  )

  class << self
    def [](light_type = :point)
      new.tap do |rd|
        rd[:light_type] = light_type.object_id
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
