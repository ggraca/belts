require "belts_support"
require "belts_assets"

# TODO: Load with zeitwerk
require_relative "./belts_engine/structs/vec2"
require_relative "./belts_engine/structs/vec3"
require_relative "./belts_engine/structs/vec4"
require_relative "./belts_engine/structs/quat"
require_relative "./belts_engine/structs/mat4"
require_relative "./belts_engine/components/transform"
require_relative "./belts_engine/components/camera"
require_relative "./belts_engine/components/light"
require_relative "./belts_engine/components/render_data"

loader = Zeitwerk::Loader.for_gem
loader.setup

module BeltsEngine
end
