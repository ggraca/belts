module Flecs
  class StackCursor < FFI::Struct
    layout(
      prev: StackCursor.by_ref,
      page: :pointer,
      sp: :int16,
      is_free: :bool,
    )
  end
end
