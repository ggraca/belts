module Assimp
  class Vector3D < FFI::Struct
    layout(x: :float, y: :float, z: :float)
  end
end
