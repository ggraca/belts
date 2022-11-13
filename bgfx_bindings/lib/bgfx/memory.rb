module BGFX
  class Memory < FFI::Struct
    layout(
      data: :pointer,
      size: :uint
    )
  end
end
