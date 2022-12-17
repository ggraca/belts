module Assimp
  class MeshList < FFI::Struct
    layout mesh: Mesh.ptr
  end

  class Scene < FFI::Struct
    layout(
      mFlags: :uint,
      mRootNode: :pointer, # TODO: Node.ptr
      mNumMeshes: :uint,
      mMeshes: MeshList.ptr, # TODO: Mesh.ptr
      mNumMaterials: :uint,
      mMaterials: :pointer, # TODO: Material.ptr
      mNumAnimations: :uint,
      mAnimations: :pointer, # TODO: Animation.ptr
      mNumTextures: :uint,
      mTextures: :pointer, # TODO: Texture.ptr
      mNumLights: :uint,
      mLights: :pointer, # TODO: Light.ptr
      mNumCameras: :uint,
      mCameras: :pointer, # TODO: Camera.ptr
      mMetaData: :pointer, # TODO: MetaData.ptr
      mPrivate: :pointer
    )
  end
end
