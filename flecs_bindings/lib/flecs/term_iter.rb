module Flecs
  class TermIter < FFI::Struct
    class TableCacheIter < FFI::Struct
      layout(
        cur: :ecs_table_cache_hdr_tp,
        next: :ecs_table_cache_hdr_tp,
        next_list: :ecs_table_cache_hdr_tp
      )
    end

    layout(
      term: Term.by_value,
      self_index: :ecs_id_record_tp,
      set_index: :ecs_id_record_tp,
      cur: :ecs_id_record_tp,
      it: TableCacheIter.by_value,
      index: :int32,
      observed_table_count: :int32,

      table: :ecs_table_tp,
      cur_match: :int32,
      match_count: :int32,
      last_column: :int32,

      empty_tables: :bool,

      id: :ecs_id_t,
      column: :int32,
      subject: :ecs_entity_t,
      size: :ecs_size_t,
      ptr: :pointer,
    )
  end
end
