class RenderData < BeltsSupport::Component
  layout(
    model: :ulong
  )

  class << self
    def [](model)
      new.tap do |rd|
        rd.model = model
      end
    end
  end

  def model=(model)
    self[:model] = model.object_id
  end

  def model
    ObjectSpace._id2ref(self[:model])
  end
end
