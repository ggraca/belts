require 'zeitwerk'
require 'matrix'
require 'active_support/inflector'
require 'active_support/core_ext/module/delegation'
require 'belts_engine'
require 'belts_opengl'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Belts
end
