require "active_support/inflector"
require "active_support/configurable"
require "active_support/core_ext/class/subclasses"
require "ffi"
require "zeitwerk"
require_relative "patches"

loader = Zeitwerk::Loader.for_gem
loader.setup

module BeltsSupport
end
