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
loader.setup

module BeltsEngine
end
