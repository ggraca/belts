module Flecs
  class System < FFI::Struct
    layout(
      _canary: :int32,
      entity: :ecs_entity_t,
      query: Query.by_value,
      run: :ecs_run_action_t,
      callback: :ecs_iter_action_t,
      ctx: :pointer,
      binding_ctx: :pointer,
      ctx_free: :ecs_ctx_free_t,
      binding_ctx_free: :ecs_ctx_free_t,
      interval: :ecs_ftime_t,
      rate: :int32,
      tick_source: :ecs_entity_t,
      multi_threaded: :bool,
      no_readonly: :bool,
    )
  end
end
