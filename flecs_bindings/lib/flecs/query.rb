module Flecs
  class Query < FFI::Struct
    layout(
      _canary: :int32,
      filter: Filter.by_value,
      order_by_component: :ecs_entity_t,
      order_by: :pointer, # TODO: ecs_order_by_action_t,
      group_by_id: :ecs_id_t,
      group_by: :pointer, # TODO: ecs_group_by_action_t,
      group_by_ctx: :pointer, #TODO
      group_by_ctx_free: :pointer, #TODO ecs_ctx_free_t
      parent: Query.by_ref,
      system: :ecs_entity_t,
    )
  end
end
