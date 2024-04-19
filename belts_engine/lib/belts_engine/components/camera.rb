class Camera < BeltsSupport::Component
  layout(
    type: :ulong
  )

  class << self
    def [](type: :perspective)
      new.tap do |rd|
        rd[:type] = type.object_id
      end
    end
  end

  def type
    ObjectSpace._id2ref(self[:type])
  end

  def perspective? = type == :perspective
  def orthographic? = type == :orthographic
end
