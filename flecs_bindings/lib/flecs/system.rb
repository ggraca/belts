module Flecs
  class System < FFI::Struct
    layout(
      _canary: :int32,
      entity: Entity.by_value,
      query: Query.by_value,
      run: :ecs_run_action_t,
      callback: :ecs_iter_action_t,
      status_callback: :pointer, #TODO: :ecs_system_status_action_t,
      self: :ecs_entity_t,
      ctx: :pointer, # TODO: :?*anyopaque,
      status_ctx: :pointer, # TODO: :?*anyopaque,
      binding_ctx: :pointer, # TODO: :?*anyopaque,
      ctx_free: :pointer, # TODO: :ecs_ctx_free_t,
      status_ctx_free: :pointer, # TODO: :ecs_ctx_free_t,
      binding_ctx_free: :pointer, # TODO: :ecs_ctx_free_t,
      interval: :float,
      rate: :int32,
      tick_source: :ecs_entity_t,
      multi_threaded: :bool,
      no_staging: :bool,
    )
  end
end
