require "active_support/inflector"
require "active_support/configurable"
require "active_support/core_ext/module/delegation"
require "active_support/core_ext/class/subclasses"
require "flecs"
require "glm"
require "assimp"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module BeltsSupport
end
