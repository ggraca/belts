module Flecs
  class Term < FFI::Struct
    layout(
      id: :ecs_id_t,
      inout: :ecs_inout_kind_t,
      pred: TermId.by_value,
      subj: TermId.by_value,
      obj: TermId.by_value,
      oper: :ecs_oper_kind_t,
      role: :ecs_id_t,
      name: :pointer,
      index: :int32,
      move: :bool,
    )
  end
end
