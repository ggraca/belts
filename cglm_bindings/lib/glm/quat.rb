module GLM
  class Quat < FFI::Struct
    layout :values, [:float, 4]
  end
end
