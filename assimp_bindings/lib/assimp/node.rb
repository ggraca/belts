module Assimp
  class String < FFI::Struct
    layout(
      length: :uint,
      data: [:char, 1024]
    )
  end

  class Node < FFI::Struct
    layout(
      mName: String,
      mTransformation: [:float, 16],
      mParent: Node.ptr,
      mNumChildren: :uint,
      mChildren: NodePointer.ptr,
      mNumMeshes: :uint,
      mMeshes: :pointer, # TODO
      mMetaData: :pointer, # TODO: MetaData.ptr
    )
  end
end
