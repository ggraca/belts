require "ffi"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "glm" => "GLM"
loader.setup

module GLM
  extend FFI::Library

  def self.load_lib(path = :libcglm)
    # NOTE: requires export CFLAGS="DCGLM_CLIPSPACE_INCLUDE_ALL=1 -DCGLM_FORCE_DEPTH_ZERO_TO_ONE=1 -DCGLM_FORCE_LEFT_HANDED=1"
    # NOTE: requires export CFLAGS="-DCGLM_FORCE_LEFT_HANDED=1"
    ffi_lib path

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

    attach_function :glmc_quat_identity, [GLM::Quat.by_ref], :void
    attach_function :glmc_quat_mat4, [GLM::Quat.by_ref, GLM::Mat4.by_ref], :void
    attach_function :glmc_quat_inv, [GLM::Quat.by_ref, GLM::Quat.by_ref], :void
    attach_function :glmc_quatv, [GLM::Quat.by_ref, :float, GLM::Vec3.by_ref], :void
    attach_function :glmc_quat_mul, [GLM::Quat.by_ref, GLM::Quat.by_ref, GLM::Quat.by_ref], :void
    attach_function :glmc_quat_rotatev, [GLM::Quat.by_ref, GLM::Vec3.by_ref, GLM::Vec3.by_ref], :void

    attach_function :glmc_mat4_identity, [GLM::Mat4.by_ref], :void
    attach_function :glmc_mat4_mul, [GLM::Mat4.by_ref, GLM::Mat4.by_ref, GLM::Mat4.by_ref], :void
    attach_function :glmc_mat4_mulN, [:pointer, :int, GLM::Mat4.by_ref], :void
    attach_function :glmc_mat4_transpose_to, [GLM::Mat4.by_ref, GLM::Mat4.by_ref], :void
    attach_function :glmc_mat4_inv, [GLM::Mat4.by_ref, GLM::Mat4.by_ref], :void

    attach_function :glmc_translate, [GLM::Mat4.by_ref, GLM::Vec3.by_ref], :void
    attach_function :glmc_translate_make, [GLM::Mat4.by_ref, GLM::Vec3.by_ref], :void
    attach_function :glmc_translate_to, [GLM::Mat4.by_ref, GLM::Vec3.by_ref, GLM::Mat4.by_ref], :void
    attach_function :glmc_scale, [GLM::Mat4.by_ref, GLM::Vec3.by_ref], :void
    attach_function :glmc_scale_make, [GLM::Mat4.by_ref, GLM::Vec3.by_ref], :void
    attach_function :glmc_rotate_x, [GLM::Mat4.by_ref, :float, GLM::Mat4.by_ref], :void
    attach_function :glmc_rotate_y, [GLM::Mat4.by_ref, :float, GLM::Mat4.by_ref], :void
    attach_function :glmc_rotate_z, [GLM::Mat4.by_ref, :float, GLM::Mat4.by_ref], :void

    attach_function :glmc_perspective, [:float, :float, :float, :float, GLM::Mat4.by_ref], :void
    attach_function :glmc_lookat, [GLM::Vec3.by_ref, GLM::Vec3.by_ref, GLM::Vec3.by_ref, GLM::Mat4.by_ref], :void
  end
end
