module Flecs
  class TypeHooks < FFI::Struct
    layout(
      ctor: :ecs_xtor_t,
      dtor: :ecs_xtor_t,
      copy: :ecs_copy_t,
      move: :ecs_move_t,
      copy_ctor: :ecs_copy_t,
      move_ctor: :ecs_move_t,
      ctor_move_dtor: :ecs_move_t,
      move_dtor: :ecs_move_t,
      on_add: :ecs_iter_action_t,
      on_set: :ecs_iter_action_t,
      on_remove: :ecs_iter_action_t,
      ctx: :pointer,
      binding_ctx: :pointer,
      ctx_free: :ecs_ctx_free_t,
      binding_ctx_free: :ecs_ctx_free_t
    )
  end
end
