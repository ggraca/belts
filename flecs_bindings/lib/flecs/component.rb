module Flecs
  class Component < FFI::Struct
    layout(
      _canary: :int32,
      entity: :ecs_entity_t,
      type: TypeInfo.by_value,
    )
  end
end
