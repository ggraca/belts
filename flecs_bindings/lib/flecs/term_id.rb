module Flecs
  class TermId < FFI::Struct
    layout(
      entity: :ecs_entity_t,
      name: :pointer,
      trav: :ecs_entity_t,
      flags: :ecs_flags32_t,
    )
  end
end
