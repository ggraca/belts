module Flecs
  class Var < FFI::Struct
    layout(
      range: TableRange.by_value,
      entity: Entity.by_value,
    )
  end
end
