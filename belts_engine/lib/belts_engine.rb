require "belts_support"
require "belts_assets"

# TODO: Load with zeitwerk
require_relative "./belts_engine/structs/vec2_behaviour"
require_relative "./belts_engine/structs/vec3_behaviour"
require_relative "./belts_engine/structs/vec4_behaviour"
require_relative "./belts_engine/structs/quat_behaviour"
require_relative "./belts_engine/structs/mat4_behaviour"
require_relative "./belts_engine/structs/vec2"
require_relative "./belts_engine/structs/vec3"
require_relative "./belts_engine/structs/vec4"
require_relative "./belts_engine/structs/quat"
require_relative "./belts_engine/structs/mat4"
require_relative "./belts_engine/components/camera"
require_relative "./belts_engine/components/light"
require_relative "./belts_engine/components/render_data"
require_relative "./belts_engine/components/position"
require_relative "./belts_engine/components/rotation"
require_relative "./belts_engine/components/scale"
require_relative "./belts_engine/components/transform_matrix"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "belts_bgfx" => "BeltsBGFX"
# loader.collapse("#{__dir__}/belts_engine/structs")
# loader.collapse("#{__dir__}/belts_engine/components")
loader.setup

module BeltsEngine
end

# NOTE: Preloads systems because these are found via BeltsEngine::System.descendants
loader.preload("#{__dir__}/belts_bgfx/systems")

# NOTE: Monkey patch to allow any structs to be passed
# TODO: Move to a monkey patch file
module FFI
  class Struct
    def self.ignore_reference? = false
  end

  class StructByReference
    def to_native(value, ctx)
      # TODO: This check still consumes 1/3 of the function call time
      return value.pointer if value.class.ignore_reference?
      return Pointer::NULL if value.nil?

      unless @struct_class === value
        raise TypeError, "wrong argument type #{value.class} (expected #{@struct_class})"
      end

      value.pointer
    end
  end
end
