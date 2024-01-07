module Flecs
  class Iter < FFI::Struct
    layout(
      # World
      world: :ecs_world_tp,
      real_world: :ecs_world_tp,

      # Matched data
      entities: :ecs_entity_tp,
      ptrs: :pointer,
      sizes: :pointer,
      table: :pointer,
      other_table: :pointer,
      ids: :pointer,
      variables: Var.by_ref,
      columns: :pointer,
      sources: :pointer,
      match_indices: :pointer,

      references: :pointer,
      constrained_vars: :ecs_flags64_t,
      group_id: :uint64,
      field_count: :int32,

      # Input information
      system: :ecs_entity_t,
      event: :ecs_entity_t,
      event_id: :ecs_id_t,

      # Query information
      terms: Term.by_ref,
      table_count: :int32,
      term_index: :int32,

      variable_count: :int32,
      variable_names: :pointer,

      # Context
      param: :pointer,
      ctx: :pointer,
      binding_ctx: :pointer,

      # Time
      delta_time: :ecs_ftime_t,
      delta_system_time: :ecs_time_t,

      # Iterator counters
      frame_offset: :int32,
      offset: :int32,
      count: :int32,
      instance_count: :int32,

      # Iterator flags
      flags: :ecs_flags32_t,

      interrupted_by: :ecs_entity_t,

      priv: IterPrivate.by_value,

      # Chained iterators
      next: :ecs_iter_next_action_t,
      callback: :ecs_iter_action_t,
      set_var: :ecs_iter_action_t,
      fini: :ecs_iter_fini_action_t,
      chain_it: Iter.by_ref,
    )
  end
end
