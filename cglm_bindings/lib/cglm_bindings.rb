require "ffi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Glm
  extend FFI::Library
  ffi_lib :libcglm

  attach_function :glmc_vec2_one, [Glm::Vec2.by_ref], :void
  attach_function :glmc_vec2_dot, [Glm::Vec2.by_ref, Glm::Vec2.by_ref], :float
  attach_function :glmc_vec2_adds, [Glm::Vec2.by_ref, :float, Glm::Vec2.by_ref], :void
  attach_function :glmc_vec2_add, [Glm::Vec2.by_ref, Glm::Vec2.by_ref, Glm::Vec2.by_ref], :void
  attach_function :glmc_vec2_scale, [Glm::Vec2.by_ref, :float, Glm::Vec2.by_ref], :void
  attach_function :glmc_vec2_mul, [Glm::Vec2.by_ref, Glm::Vec2.by_ref, Glm::Vec2.by_ref], :void
end
