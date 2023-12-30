require "ffi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Flecs
  extend FFI::Library

  ffi_lib :libflecs

  typedef :pointer, :ecs_world_t
  typedef :uint64, :ecs_id_t
  typedef :ecs_id_t, :ecs_entity_t
  typedef :uint, :ecs_oper_kind_t
  typedef :uint, :ecs_inout_kind_t
  typedef :uint32, :ecs_flags32_t
  typedef :uint16, :ecs_flags16_t
  typedef :int32, :ecs_size_t
  typedef :pointer, :ecs_xtor_t
  typedef :pointer, :ecs_copy_t
  typedef :pointer, :ecs_move_t
  typedef :float, :ecs_ftime_t

  [:EcsChildOf].each do |name|
    attach_variable name, :ecs_entity_t
  end

  callback :ecs_iter_action_t, [:pointer], :void
  callback :ecs_run_action_t, [:pointer], :void
  callback :ecs_ctx_free_t, [:pointer], :void

  # World
  attach_function :ecs_init, [], :ecs_world_t
  attach_function :ecs_fini, [:ecs_world_t], :void

  # Id
  attach_function :ecs_new_id, [:ecs_world_t], :ecs_id_t

  # Entity
  attach_function :ecs_entity_init, [:ecs_world_t, Entity.by_ref], :ecs_entity_t
  attach_function :ecs_is_alive, [:ecs_world_t, :ecs_entity_t], :bool
  attach_function :ecs_delete, [:ecs_world_t, :ecs_entity_t], :void

  # Component
  attach_function :ecs_component_init, [:ecs_world_t, Component.by_ref], :ecs_entity_t
  attach_function :ecs_add_id, [:ecs_world_t, :ecs_entity_t, :ecs_id_t], :void
  attach_function :ecs_set_id, [:ecs_world_t, :ecs_entity_t, :ecs_id_t, :ecs_size_t, :pointer], :void
  attach_function :ecs_has_id, [:ecs_world_t, :ecs_entity_t, :ecs_id_t], :bool
  attach_function :ecs_get_id, [:ecs_world_t, :ecs_entity_t, :ecs_id_t], :pointer
  attach_function :ecs_remove_id, [:ecs_world_t, :ecs_entity_t, :ecs_id_t], :void

  # Filter
  attach_function :ecs_filter_init, [:ecs_world_t, Filter.by_ref], Filter.by_ref

  # Query
  attach_function :ecs_query_init, [:ecs_world_t, Query.by_ref], Query.by_ref

  # System
  attach_function :ecs_system_init, [:ecs_world_t, System.by_ref], :ecs_entity_t
  attach_function :ecs_run, [:ecs_world_t, :ecs_entity_t, :float, :pointer], :ecs_entity_t
end
