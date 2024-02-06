module Flecs
  class StackCursor < FFI::Struct
    layout(
      prev: StackCursor.by_ref,
      page: :ecs_stack_page_tp,
      sp: :int16,
      is_free: :bool
      # owner: :ecs_stack_tp # NOTE: DEBUG ONLY
    )
  end
end
