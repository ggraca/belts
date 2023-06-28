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
  typedef :uint, :ecs_var_kind_t
  typedef :uint, :ecs_oper_kind_t
  typedef :uint, :ecs_inout_kind_t

  callback :ecs_iter_action_t, [:pointer], :void
  callback :ecs_run_action_t, [:pointer], :void

  attach_function :ecs_init, [], :ecs_world_t
  attach_function :ecs_fini, [:ecs_world_t], :void

  attach_function :ecs_new_id, [:ecs_world_t], :ecs_id_t
  attach_function :ecs_add_id, [:ecs_world_t, :ecs_entity_t, :ecs_id_t], :void
  attach_function :ecs_has_id, [:ecs_world_t, :ecs_entity_t, :ecs_id_t], :bool

  attach_function :ecs_system_init, [:ecs_world_t, System.by_ref], :ecs_entity_t
  attach_function :ecs_run, [:ecs_world_t, :ecs_entity_t, :float,:pointer], :ecs_entity_t
end
