module Flecs
  class Var < FFI::Struct
    layout(
      range: TableRange.by_value,
      entity: :ecs_entity_t,
    )
  end
end
