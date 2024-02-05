module Flecs
  class TypeInfo < FFI::Struct
    layout(
      size: :ecs_size_t,
      alignment: :ecs_size_t,
      hooks: TypeHooks.by_value,
      component: :ecs_entity_t,
      name: :pointer
    )
  end
end
