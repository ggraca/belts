require "ffi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Flecs
  extend FFI::Library

  ffi_lib :libflecs

  # Enums
  IterKind = enum [
    :EcsIterEvalCondition,
    :EcsIterEvalTables,
    :EcsIterEvalChain,
    :EcsIterEvalNone
  ]

  typedef :uint64, :ecs_id_t
  typedef :ecs_id_t, :ecs_entity_t
  typedef :uint, :ecs_oper_kind_t
  typedef :uint, :ecs_inout_kind_t
  typedef :uint8, :ecs_flags8_t
  typedef :uint16, :ecs_flags16_t
  typedef :uint32, :ecs_flags32_t
  typedef :uint64, :ecs_flags64_t
  typedef :int32, :ecs_size_t
  typedef :float, :ecs_ftime_t

  # Pointers to internal structs
  typedef :pointer, :ecs_world_tp
  typedef :pointer, :ecs_entity_tp
  typedef :pointer, :ecs_query_tp
  typedef :pointer, :ecs_filter_tp
  typedef :pointer, :ecs_id_record_tp
  typedef :pointer, :ecs_table_cache_hdr_tp
  typedef :pointer, :ecs_table_tp
  typedef :pointer, :ecs_query_table_match_tp
  typedef :pointer, :ecs_rule_tp
  typedef :pointer, :ecs_rule_var_tp
  typedef :pointer, :ecs_rule_op_tp
  typedef :pointer, :ecs_rule_op_ctx_tp
  typedef :pointer, :ecs_mixins_tp
  typedef :pointer, :ecs_stack_page_tp
  typedef :pointer, :ecs_stack_tp

  # Pointers to internal callbacks
  typedef :pointer, :ecs_xtor_t
  typedef :pointer, :ecs_copy_t
  typedef :pointer, :ecs_move_t
  typedef :pointer, :ecs_poly_dtor_t
  typedef :pointer, :ecs_iter_init_action_t
  typedef :pointer, :ecs_iter_next_action_t
  typedef :pointer, :ecs_iter_fini_action_t

  [:EcsChildOf].each do |name|
    attach_variable name, :ecs_entity_t
  end

  callback :ecs_iter_action_t, [:pointer], :void
  callback :ecs_run_action_t, [:pointer], :void
  callback :ecs_ctx_free_t, [:pointer], :void

  # World
  attach_function :ecs_init, [], :ecs_world_tp
  attach_function :ecs_fini, [:ecs_world_tp], :void

  # Id
  attach_function :ecs_new_id, [:ecs_world_tp], :ecs_id_t

  # Entity
  attach_function :ecs_entity_init, [:ecs_world_tp, EntityDesc.by_ref], :ecs_entity_t
  attach_function :ecs_is_alive, [:ecs_world_tp, :ecs_entity_t], :bool
  attach_function :ecs_delete, [:ecs_world_tp, :ecs_entity_t], :void

  # Component
  attach_function :ecs_component_init, [:ecs_world_tp, ComponentDesc.by_ref], :ecs_entity_t
  attach_function :ecs_add_id, [:ecs_world_tp, :ecs_entity_t, :ecs_id_t], :void
  attach_function :ecs_set_id, [:ecs_world_tp, :ecs_entity_t, :ecs_id_t, :ecs_size_t, :pointer], :void
  attach_function :ecs_has_id, [:ecs_world_tp, :ecs_entity_t, :ecs_id_t], :bool
  attach_function :ecs_get_id, [:ecs_world_tp, :ecs_entity_t, :ecs_id_t], :pointer
  attach_function :ecs_remove_id, [:ecs_world_tp, :ecs_entity_t, :ecs_id_t], :void

  # Pair
  attach_function :ecs_make_pair, [:ecs_entity_t, :ecs_entity_t], :ecs_id_t

  # Filter
  attach_function :ecs_filter_init, [:ecs_world_tp, FilterDesc.by_ref], Filter.by_ref
  attach_function :ecs_filter_iter, [:ecs_world_tp, :ecs_filter_tp], Iter.by_value
  attach_function :ecs_filter_fini, [:ecs_filter_tp], :void
  attach_function :ecs_filter_next, [Iter.by_ref], :bool

  # Query
  attach_function :ecs_query_init, [:ecs_world_tp, QueryDesc.by_ref], :ecs_query_tp

  # System
  attach_function :ecs_system_init, [:ecs_world_tp, SystemDesc.by_ref], :ecs_entity_t
  attach_function :ecs_run, [:ecs_world_tp, :ecs_entity_t, :float, :pointer], :ecs_entity_t
end
