module Flecs
  class FilterIter < FFI::Struct
    layout(
      filter: Filter.by_ref,
      kind: IterKind,
      term_iter: TermIter.by_value,
      matches_left: :int32,
      pivot_term: :int32
    )
  end
end
