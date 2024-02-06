module Flecs
  class PageIter < FFI::Struct
    layout(
      offset: :int32,
      limit: :int32,
      remaining: :int32
    )
  end
end
