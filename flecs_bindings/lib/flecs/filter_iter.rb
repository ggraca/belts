module Flecs
  class FilterIter < FFI::Struct
    IterKind = enum [
      :EcsIterEvalCondition,
      :EcsIterEvalTables,
      :EcsIterEvalChain,
      :EcsIterEvalNone
    ]

    layout(
      filter: Filter.by_ref,
      kind: IterKind,
      term_iter: TermIter.by_value,
      matches_left: :int32,
      pivot_term: :int32
    )
  end
end
