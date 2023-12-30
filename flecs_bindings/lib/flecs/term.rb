module Flecs
  class Term < FFI::Struct
    layout(
      id: :ecs_id_t,
      src: TermId.by_value,
      first: TermId.by_value,
      second: TermId.by_value,
      inout: :ecs_inout_kind_t,
      oper: :ecs_oper_kind_t,
      id_flags: :ecs_id_t,
      name: :pointer,
      field_index: :int32,
      idr: :pointer, # TODO: ecs_id_record_t
      flags: :ecs_flags16_t,
      move: :bool,
    )
  end
end
