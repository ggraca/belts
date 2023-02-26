module GLM
  class Vec4 < FFI::Struct
    layout :values, [:float, 4]
  end
end
