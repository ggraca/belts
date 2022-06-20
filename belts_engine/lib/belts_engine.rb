require "belts_support"

# TODO: Load with zeitwerk
require_relative "./belts_engine/components/vec3"
require_relative "./belts_engine/components/mat4"
require_relative "./belts_engine/components/transform"

loader = Zeitwerk::Loader.for_gem
loader.setup

module BeltsEngine
end
