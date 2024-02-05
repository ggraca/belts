require "belts_support"
require_relative "./patches"

# TODO: Load with zeitwerk
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

# NOTE: Preloads systems because these are found via BeltsEngine::System.descendants
loader.preload("#{__dir__}/belts_core/systems")
loader.preload("#{__dir__}/belts_bgfx/systems")
