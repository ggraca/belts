module Flecs
  class TableRange < FFI::Struct
    layout(
      table: :ecs_table_tp,
      offset: :int32,
      count: :int32,
    )
  end
end
