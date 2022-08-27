require "ffi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "glm" => "GLM"
loader.setup

module GLM
  extend FFI::Library
  ffi_lib :libcglm

  attach_function :glmc_vec2_adds, [GLM::Vec2.by_ref, :float, GLM::Vec2.by_ref], :void
  attach_function :glmc_vec2_add, [GLM::Vec2.by_ref, GLM::Vec2.by_ref, GLM::Vec2.by_ref], :void
  attach_function :glmc_vec2_scale, [GLM::Vec2.by_ref, :float, GLM::Vec2.by_ref], :void
  attach_function :glmc_vec2_mul, [GLM::Vec2.by_ref, GLM::Vec2.by_ref, GLM::Vec2.by_ref], :void

  attach_function :glmc_vec3_negate, [GLM::Vec3.by_ref], :void
  attach_function :glmc_vec3_negate_to, [GLM::Vec3.by_ref, GLM::Vec3.by_ref], :void
  attach_function :glmc_vec3_adds, [GLM::Vec3.by_ref, :float, GLM::Vec3.by_ref], :void
  attach_function :glmc_vec3_add, [GLM::Vec3.by_ref, GLM::Vec3.by_ref, GLM::Vec3.by_ref], :void
  attach_function :glmc_vec3_scale, [GLM::Vec3.by_ref, :float, GLM::Vec3.by_ref], :void
  attach_function :glmc_vec3_mul, [GLM::Vec3.by_ref, GLM::Vec3.by_ref, GLM::Vec3.by_ref], :void

  attach_function :glmc_mat4_mul, [GLM::Mat4.by_ref, GLM::Mat4.by_ref, GLM::Mat4.by_ref], :void
  attach_function :glmc_mat4_transpose_to, [GLM::Mat4.by_ref, GLM::Mat4.by_ref], :void
  attach_function :glmc_mat4_inv, [GLM::Mat4.by_ref, GLM::Mat4.by_ref], :void

  attach_function :glmc_translate, [GLM::Mat4.by_ref, GLM::Vec3.by_ref], :void
  attach_function :glmc_translate_to, [GLM::Mat4.by_ref, GLM::Vec3.by_ref, GLM::Mat4.by_ref], :void
  attach_function :glmc_scale, [GLM::Mat4.by_ref, GLM::Vec3.by_ref], :void
  attach_function :glmc_rotate_x, [GLM::Mat4.by_ref, :float, GLM::Mat4.by_ref], :void
  attach_function :glmc_rotate_y, [GLM::Mat4.by_ref, :float, GLM::Mat4.by_ref], :void
  attach_function :glmc_rotate_z, [GLM::Mat4.by_ref, :float, GLM::Mat4.by_ref], :void

  attach_function :glmc_perspective, [:float, :float, :float, :float, GLM::Mat4.by_ref], :void
end