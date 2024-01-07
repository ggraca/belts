module Flecs
  class RuleIter < FFI::Struct
    layout(
      rule: :ecs_rule_tp,
      vars: Var.by_ref,
      rule_vars: :ecs_rule_var_tp,
      ops: :ecs_rule_op_tp,
      op_ctx: :ecs_rule_op_ctx_tp,
      written: :pointer,
      source_set: :ecs_flags32_t,

      op: :int16,
      sp: :int16,
    )
  end
end
