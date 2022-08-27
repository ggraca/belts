module BGFX
  class PlatformData < FFI::Struct
    layout ndt: :pointer,
      nwh: :pointer,
      context: :pointer,
      backBuffer: :pointer,
      backBufferDS: :pointer
  end
end
