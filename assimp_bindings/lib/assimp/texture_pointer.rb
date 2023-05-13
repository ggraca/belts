module Assimp
  class TexturePointer < FFI::Struct
    layout texture: Texture.ptr
  end
end
