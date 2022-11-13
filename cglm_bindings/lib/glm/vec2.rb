module GLM
  class Vec2 < FFI::Struct
    layout :values, [:float, 2]
  end
end
