module BGFX
  class Init < FFI::Struct
    layout(
      type: RendererType,
      vendorId: :ushort,
      deviceId: :ushort,
      capabilities: :ulong,
      _debug: :bool,
      profile: :bool,
      platformData: PlatformData,
      resolution: Resolution,
      limits: InitLimits,
      callback: :pointer,
      allocator: :pointer
    )

    def initialize(resolution:)
      super()
      self[:resolution] = resolution
    end
  end
end
