module Flecs
  class IterCache < FFI::Struct
    layout(
      stack_cursor: StackCursor.by_ref,
      used: :ecs_flags8_t,
      allocated: :ecs_flags8_t
    )
  end
end
