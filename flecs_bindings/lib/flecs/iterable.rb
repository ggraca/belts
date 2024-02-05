module Flecs
  class Iterable < FFI::Struct
    layout(
      init: :ecs_iter_init_action_t
    )
  end
end
