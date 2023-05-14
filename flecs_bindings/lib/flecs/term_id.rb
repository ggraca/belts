module Flecs
  class TermId < FFI::Struct
    layout(
      entity: :ecs_entity_t,
      name: :pointer,
      var: :ecs_var_kind_t,
      set: TermSet.by_value,
    )
  end
end
