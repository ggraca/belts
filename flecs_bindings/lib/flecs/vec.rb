module Flecs
  class Vec < FFI::Struct
    layout(
      array: :pointer,
      count: :int32,
      size: :int32,
    )
  end
end
