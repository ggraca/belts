class Camera < BeltsSupport::Component
  layout(
    projection_type: :ulong,
  )

  class << self
    def [](projection_type = :perspective)
      new.tap do |rd|
        rd[:projection_type] = projection_type.object_id
      end
    end
  end

  def projection_type
    ObjectSpace._id2ref(self[:projection_type])
  end

  def perspective? = projection_type == :perspective
  def orthographic? = projection_type == :orthographic
end
