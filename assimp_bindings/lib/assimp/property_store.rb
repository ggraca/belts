module Assimp
  class PropertyStore < FFI::Struct
    layout(
      sentinel: :char
    )
  end
end
