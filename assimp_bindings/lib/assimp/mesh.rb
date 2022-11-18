module Assimp
  AI_MAX_FACE_INDICES = 0x7fff
  AI_MAX_BONE_WEIGHTS = 0x7fffffff
  AI_MAX_VERTICES = 0x7fffffff
  AI_MAX_FACES = 0x7fffffff
  AI_MAX_NUMBER_OF_COLOR_SETS = 0x8
  AI_MAX_NUMBER_OF_TEXTURECOORDS = 0x8

  class Mesh < FFI::Struct
    layout(
      mPrimitiveTypes: :uint,
      mNumVertices: :uint,
      mNumFaces: :uint,
      mVertices: Vector3D.ptr, # TODO: Vector3D.ptr
      mNormals: :pointer, # TODO: Vector3D.ptr
      mTangents: :pointer, # TODO: Vector3D.ptr
      mBitangents: :pointer, # TODO: Vector3D.ptr
      mColors: [:pointer, AI_MAX_NUMBER_OF_COLOR_SETS], # TODO: Color4D.ptr
      mTextureCoords: [:pointer, AI_MAX_NUMBER_OF_TEXTURECOORDS], # TODO: Vector3D.ptr
      mNumUVComponents: [:uint, AI_MAX_NUMBER_OF_TEXTURECOORDS],
      mFaces: :pointer, # TODO: Face.ptr
      mNumBones: :uint,
      mBones: :pointer, # TODO: Bone.ptr
      mMaterialIndex: :uint,
      mName: :string,
      mNumAnimMeshes: :uint,
      mAnimMeshes: :pointer, # TODO: AnimMesh.ptr
      mMethod: :uint
    )
  end
end
