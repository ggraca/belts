module Flecs
  class QueryIter < FFI::Struct
    layout(
      query: :ecs_query_tp,
      node: :ecs_query_table_match_tp,
      prev: :ecs_query_table_match_tp,
      last: :ecs_query_table_match_tp,
      sparse_smallest: :int32,
      sparse_first: :int32,
      table_count: :int32,
      bitset_first: :int32,
      skip_count: :int32
    )
  end
end
