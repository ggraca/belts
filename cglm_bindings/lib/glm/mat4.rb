module GLM
  class Mat4 < FFI::Struct
    layout :values, [:float, 16]
  end
end
