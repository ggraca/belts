require "ffi"
require "zeitwerk"

# TODO: use zeitwerk to load these files
require_relative "constants"
require_relative "enums"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "bgfx" => "BGFX"
loader.setup

module BGFX
  extend FFI::Library
  ffi_lib :libbgfx

  attach_function :init, :bgfx_init, [Init], :bool
  attach_function :setDebug, :bgfx_set_debug, [:uint], :void
  attach_function :setViewClear, :bgfx_set_view_clear, [:ushort, :ushort, :uint, :float, :uint8], :void
  attach_function :frame, :bgfx_frame, [:bool], :uint
  attach_function :setViewRect, :bgfx_set_view_rect, [:ushort, :ushort, :ushort, :ushort, :ushort], :void
  attach_function :touch, :bgfx_touch, [:ushort], :void
  attach_function :setPlatformData, :bgfx_set_platform_data, [PlatformData.by_ref], :void
  attach_function :render_frame, :bgfx_render_frame, [:int], :uint8
end
