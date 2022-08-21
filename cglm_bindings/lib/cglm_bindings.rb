require "ffi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.setup

module Glm
  extend FFI::Library
  ffi_lib :libcglm

  attach_function :glmc_vec2_adds, [Glm::Vec2.by_ref, :float, Glm::Vec2.by_ref], :void
  attach_function :glmc_vec2_add, [Glm::Vec2.by_ref, Glm::Vec2.by_ref, Glm::Vec2.by_ref], :void
  attach_function :glmc_vec2_scale, [Glm::Vec2.by_ref, :float, Glm::Vec2.by_ref], :void
  attach_function :glmc_vec2_mul, [Glm::Vec2.by_ref, Glm::Vec2.by_ref, Glm::Vec2.by_ref], :void

  attach_function :glmc_vec3_negate, [Glm::Vec3.by_ref], :void
  attach_function :glmc_vec3_negate_to, [Glm::Vec3.by_ref, Glm::Vec3.by_ref], :void
  attach_function :glmc_vec3_adds, [Glm::Vec3.by_ref, :float, Glm::Vec3.by_ref], :void
  attach_function :glmc_vec3_add, [Glm::Vec3.by_ref, Glm::Vec3.by_ref, Glm::Vec3.by_ref], :void
  attach_function :glmc_vec3_scale, [Glm::Vec3.by_ref, :float, Glm::Vec3.by_ref], :void
  attach_function :glmc_vec3_mul, [Glm::Vec3.by_ref, Glm::Vec3.by_ref, Glm::Vec3.by_ref], :void

  attach_function :glmc_mat4_mul, [Glm::Mat4.by_ref, Glm::Mat4.by_ref, Glm::Mat4.by_ref], :void
  attach_function :glmc_mat4_transpose_to, [Glm::Mat4.by_ref, Glm::Mat4.by_ref], :void
  attach_function :glmc_mat4_inv, [Glm::Mat4.by_ref, Glm::Mat4.by_ref], :void

  attach_function :glmc_translate, [Glm::Mat4.by_ref, Glm::Vec3.by_ref], :void
  attach_function :glmc_translate_to, [Glm::Mat4.by_ref, Glm::Vec3.by_ref, Glm::Mat4.by_ref], :void
  attach_function :glmc_scale, [Glm::Mat4.by_ref, Glm::Vec3.by_ref], :void
  attach_function :glmc_rotate_x, [Glm::Mat4.by_ref, :float, Glm::Mat4.by_ref], :void
  attach_function :glmc_rotate_y, [Glm::Mat4.by_ref, :float, Glm::Mat4.by_ref], :void
  attach_function :glmc_rotate_z, [Glm::Mat4.by_ref, :float, Glm::Mat4.by_ref], :void

  attach_function :glmc_perspective, [:float, :float, :float, :float, Glm::Mat4.by_ref], :void
end
