module Assimp
  class Face < FFI::Struct
    layout(
      mNumIndices: :uint,
      mIndices: :pointer
    )
  end
end
