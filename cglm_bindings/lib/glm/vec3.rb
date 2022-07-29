module Glm
  class Vec3 < FFI::Struct
    layout :values, [:float, 3]
  end
end
