module Assimp
  class Texture < FFI::Struct
    layout(
      mWidth: :uint,
      mHeight: :uint,
      achFormatHint: [:char, 9],
      pcData: :pointer,
      mFilename: String
    )
  end
end
