module Flecs
  class SnapshotIter < FFI::Struct
    layout(
      filter: Filter.by_value,
      tables: Vec.by_value,
      index: :int32,
    )
  end
end
