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

  typedef :ushort, :view_id
  typedef :uint8, :ubyte
  typedef :uint64, :ulong

  attach_function :init, :bgfx_init, [Init], :bool
  attach_function :set_debug, :bgfx_set_debug, [:uint], :void
  attach_function :frame, :bgfx_frame, [:bool], :uint
  attach_function :touch, :bgfx_touch, [:view_id], :void
  attach_function :set_platform_data, :bgfx_set_platform_data, [PlatformData.by_ref], :void
  attach_function :render_frame, :bgfx_render_frame, [:int], :ubyte
  attach_function :set_state, :bgfx_set_state, [:ulong, :uint], :void
  attach_function :submit, :bgfx_submit, [:view_id, ProgramHandle, :int, :ubyte], :void

  attach_function :make_ref, :bgfx_make_ref, [:pointer, :uint], Memory.by_ref
  attach_function :copy, :bgfx_copy, [:pointer, :uint], Memory.by_ref

  attach_function :vertex_layout_begin, :bgfx_vertex_layout_begin, [VertexLayout.by_ref, RendererType], VertexLayout.by_ref
  attach_function :vertex_layout_add, :bgfx_vertex_layout_add, [VertexLayout.by_ref, Attrib, :ubyte, AttribType, :bool, :bool], VertexLayout.by_ref
  attach_function :vertex_layout_end, :bgfx_vertex_layout_end, [VertexLayout.by_ref], :void

  attach_function :create_vertex_buffer, :bgfx_create_vertex_buffer, [Memory.by_ref, VertexLayout.by_ref, :ushort], VertexBufferHandle
  attach_function :set_vertex_buffer, :bgfx_set_vertex_buffer, [:uchar, VertexBufferHandle, :uint, :uint], :void
  attach_function :destroy_vertex_buffer, :bgfx_destroy_vertex_buffer, [VertexBufferHandle], :void

  attach_function :create_index_buffer, :bgfx_create_index_buffer, [Memory.by_ref, :ushort], VertexBufferHandle
  attach_function :set_index_buffer, :bgfx_set_index_buffer, [IndexBufferHandle, :uint, :uint], :void
  attach_function :destroy_index_buffer, :bgfx_destroy_index_buffer, [VertexBufferHandle], :void

  attach_function :create_shader, :bgfx_create_shader, [Memory.by_ref], ShaderHandle
  attach_function :create_program, :bgfx_create_program, [ShaderHandle, ShaderHandle, :bool], ProgramHandle
  attach_function :bgfx_destroy_program, :bgfx_destroy_program, [ProgramHandle], :void

  attach_function :set_transform, :bgfx_set_transform, [:pointer, :ushort], :void
  attach_function :set_view_clear, :bgfx_set_view_clear, [:view_id, :ushort, :uint, :float, :ubyte], :void
  attach_function :set_view_rect, :bgfx_set_view_rect, [:view_id, :ushort, :ushort, :ushort, :ushort], :void
  attach_function :set_view_transform, :bgfx_set_view_transform, [:view_id, :pointer, :pointer], :void

  attach_function :shutdown, :bgfx_shutdown, [], :void
end
