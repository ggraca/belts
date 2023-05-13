module Assimp
  class String < FFI::Struct
    layout(
      length: :uint,
      data: [:char, 1024]
    )
  end
end
