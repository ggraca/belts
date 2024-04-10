module Assimp
  class Color4D < FFI::Struct
    layout(
      r: :float,
      g: :float,
      b: :float,
      a: :float
    )
  end
end
