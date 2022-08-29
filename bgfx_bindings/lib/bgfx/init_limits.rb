module BGFX
  class InitLimits < FFI::Struct
    layout(
      maxEncoders: :ushort,
      minResourceCbSize: :uint,
      transientVbSize: :uint,
      transientIbSize: :uint
    )
  end
end
