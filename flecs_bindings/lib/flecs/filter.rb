module Flecs
  class Filter < FFI::Struct
    class Iterable < FFI::Struct
      layout(
        init: :ecs_iter_init_action_t,
      )
    end

    layout(
      hdr: Header.by_value,

      term_count: :int8,
      field_count: :int8,
      flags: :ecs_flags32_t,
      data_fields: :ecs_flags64_t,

      terms: Term.by_ref,
      variable_names: [:pointer, 1], # TODO: string instead of pointer?
      sizes: :int32,

      entity: :ecs_entity_t,
      iterable: Iterable.by_value,
      dtor: :ecs_poly_dtor_t,
      world: :ecs_world_tp,
    )
  end
end
