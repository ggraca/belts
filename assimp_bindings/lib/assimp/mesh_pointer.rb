module Assimp
  class MeshPointer < FFI::Struct
    layout mesh: Mesh.ptr
  end
end
