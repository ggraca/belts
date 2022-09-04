module BGFX
  class Resolution < FFI::Struct
    layout(
      format: TextureFormat,
      width: :uint,
      height: :uint,
      reset: :uint,
      numBackBuffers: :ubyte,
      maxFrameLatency: :ubyte
    )

    def initialize(width:, height:, reset:)
      super()
      self[:width] = width
      self[:height] = height
      self[:reset] = reset
    end
  end
end
