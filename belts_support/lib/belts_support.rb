require "active_support/inflector"
require "active_support/core_ext/module/delegation"
require "cglm_bindings"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module BeltsSupport
end
