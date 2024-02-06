module Flecs
  class WorkerIter < FFI::Struct
    layout(
      index: :int32,
      count: :int32
    )
  end
end
