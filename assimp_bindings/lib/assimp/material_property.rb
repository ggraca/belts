module Assimp
  class MaterialProperty < FFI::Struct
    layout(
      mKey: String,
      mSemantic: :uint,
      mIndex: :uint,
      mDataLength: :uint,
      mType: :uint,
      mData: :pointer
    )
  end
end
