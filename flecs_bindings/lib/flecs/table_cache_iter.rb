module Flecs
  class TableCacheIter < FFI::Struct
    layout(
      cur: :ecs_table_cache_hdr_tp,
      next: :ecs_table_cache_hdr_tp,
      next_list: :ecs_table_cache_hdr_tp
    )
  end
end
