module Flecs
  class TermSet < FFI::Struct
    layout(
      relation: :ecs_entity_t,
      mask: :char,
      min_depth: :int32,
      max_depth: :int32
    )
  end
end
