require "belts_support"
require_relative "patches"

[:vec2, :vec3, :vec4, :quat, :mat4].each do |struct|
  require_relative "./belts_engine/structs/#{struct}"
end

[:camera, :light, :render_data, :position, :rotation, :scale, :transform_matrix].each do |component|
  require_relative "./belts_engine/components/#{component}"
end

module BeltsEngine
end

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "belts_bgfx" => "BeltsBGFX"
# NOTE: Preloads key classes so that they are available using klass.descendants
loader.preload("#{__dir__}/belts_core/systems")
loader.preload("#{__dir__}/belts_bgfx/systems")
loader.setup
