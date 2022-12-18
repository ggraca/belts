module Assimp
  class String < FFI::Struct
    layout(
      length: :uint,
      data: [:char, 1024]
    )
  end

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
