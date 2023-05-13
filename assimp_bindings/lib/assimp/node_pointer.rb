module Assimp
  class NodePointer < FFI::Struct
    layout node: Node.ptr
  end
end
