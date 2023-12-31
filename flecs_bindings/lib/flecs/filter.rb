module Flecs
  class Filter < FFI::Struct
    layout(
      _canary: :int32,
      terms: [Term.by_value, 16],
      terms_buffer: Term.by_ref,
      terms_buffer_count: :int32,
      storage: :pointer,
      instanced: :bool,
      flags: :ecs_flags32_t,
      expr: :pointer,
      entity: :ecs_entity_t,
    )
  end
end
