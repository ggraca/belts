module Assimp
  class Scene < FFI::Struct
    layout(
      mFlags: :uint,
      mRootNode: Node.ptr,
      mNumMeshes: :uint,
      mMeshes: MeshPointer.ptr,
      mNumMaterials: :uint,
      mMaterials: MaterialPointer.ptr,
      mNumAnimations: :uint,
      mAnimations: :pointer, # TODO: Animation.ptr
      mNumTextures: :uint,
      mTextures: TexturePointer.ptr,
      mNumLights: :uint,
      mLights: :pointer, # TODO: Light.ptr
      mNumCameras: :uint,
      mCameras: :pointer, # TODO: Camera.ptr
      mMetaData: :pointer, # TODO: MetaData.ptr
      mPrivate: :pointer
    )
  end
end
