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
  attach_function :set_debug, :bgfx_set_debug, [:uint], :void
  attach_function :set_view_clear, :bgfx_set_view_clear, [:ushort, :ushort, :uint, :float, :uint8], :void
  attach_function :frame, :bgfx_frame, [:bool], :uint
  attach_function :set_view_rect, :bgfx_set_view_rect, [:ushort, :ushort, :ushort, :ushort, :ushort], :void
  attach_function :touch, :bgfx_touch, [:ushort], :void
  attach_function :set_platform_data, :bgfx_set_platform_data, [PlatformData.by_ref], :void
  attach_function :render_frame, :bgfx_render_frame, [:int], :uint8

  attach_function :make_ref, :bgfx_make_ref, [:pointer, :uint], Memory.by_ref

  attach_function :vertex_layout_begin, :bgfx_vertex_layout_begin, [VertexLayout.by_ref, RendererType], VertexLayout.by_ref
  attach_function :vertex_layout_add, :bgfx_vertex_layout_add, [VertexLayout.by_ref, Attrib, :uint8, AttribType, :bool, :bool], VertexLayout.by_ref
  attach_function :vertex_layout_end, :bgfx_vertex_layout_end, [VertexLayout.by_ref], :void
  attach_function :create_vertex_buffer, :bgfx_create_vertex_buffer, [Memory.by_ref, VertexLayout.by_ref, :ushort], VertexBufferHandle
  attach_function :create_index_buffer, :bgfx_create_index_buffer, [Memory.by_ref, :ushort], VertexBufferHandle

  attach_function :set_vertex_buffer, :bgfx_set_vertex_buffer, [:uchar, VertexBufferHandle, :uint, :uint], :void
  attach_function :set_index_buffer, :bgfx_set_index_buffer, [IndexBufferHandle, :uint, :uint], :void
end
