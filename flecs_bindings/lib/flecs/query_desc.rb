module Flecs
  class QueryDesc < FFI::Struct
    layout(
      _canary: :int32,
      filter: FilterDesc.by_value,
      order_by_component: :ecs_entity_t,
      order_by: :pointer, # TODO: ecs_order_by_action_t (callback)
      sort_table: :pointer, # TODO: ecs_sort_table_action_t (callback)
      group_by_id: :ecs_id_t,
      group_by: :pointer, # TODO: ecs_group_by_action_t (callback)
      on_group_create: :pointer, # TODO: ecs_group_create_action_t (callback)
      on_group_delete: :pointer, # TODO: ecs_group_delete_action_t (callback)
      group_by_ctx: :pointer,
      group_by_ctx_free: :ecs_ctx_free_t,
      parent: :ecs_query_tp,
      ctx: :pointer,
      binding_ctx: :pointer,
      ctx_free: :ecs_ctx_free_t,
      binding_ctx_free: :ecs_ctx_free_t
    )
  end
end
