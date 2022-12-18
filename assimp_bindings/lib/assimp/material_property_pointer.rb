module Assimp
  class MaterialPropertyPointer < FFI::Struct
    layout material_property: MaterialProperty.ptr
  end
end
