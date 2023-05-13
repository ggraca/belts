module Assimp
  class MaterialPointer < FFI::Struct
    layout material: Material.ptr
  end
end
