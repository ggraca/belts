module Flecs
  class Header < FFI::Struct
    layout(
      magic: :int32,
      type: :int32,
      mixins: :ecs_mixins_tp
    )
  end
end
