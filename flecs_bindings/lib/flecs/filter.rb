module Flecs
  class Filter < FFI::Struct
    layout(
      _canary: :int32,
      terms: [Term.by_value, 16],
      terms_buffer: Term.by_ref,
      terms_buffer_count: :int32,
      filter: :bool,
      instanced: :bool,
      match_empty_tables: :bool,
      expr: :pointer,
      name: :pointer,
    )
  end
end
