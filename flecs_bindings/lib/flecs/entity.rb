module Flecs
  class Entity < FFI::Struct
    layout(
      _canary: :int32,
      entity: :ecs_entity_t,
      name: :pointer,
      sep: :pointer,
      root_sep: :pointer,
      symbol: :pointer,
      use_low_id: :bool,
      add: [:ecs_id_t, 32],
      add_expr: :pointer
    )
  end
end
