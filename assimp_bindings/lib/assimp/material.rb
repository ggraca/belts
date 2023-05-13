module Assimp
  class Material < FFI::Struct
    layout(
      mProperties: MaterialPropertyPointer.ptr,
      mNumProperties: :uint,
      mNumAllocated: :uint
    )
  end
end
