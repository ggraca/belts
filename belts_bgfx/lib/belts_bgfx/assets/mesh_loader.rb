module BeltsBGFX::Assets
  class MeshLoader
    attr_reader :vah, :vbh, :ibh

    def initialize(vertices, indexes)
      @vertices = vertices
      @indexes = indexes

      unload
    end

    def load
      @vah = BGFX::VertexLayout.new
      BGFX.vertex_layout_begin(@vah, BGFX::RendererType[:Count])
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Position], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Normal], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_end(@vah)

      # TODO: review sizes
      float_size = 4 # 4 bytes
      buffer = FFI::MemoryPointer.new(:float, @vertices.size * float_size)
      buffer.write_array_of_float(@vertices)

      vertex_ref = BGFX.make_ref(buffer, @vertices.size * float_size)
      @vbh = BGFX.create_vertex_buffer(vertex_ref, @vah, 0)

      int_size = 4 # 4 bytes
      buffer = FFI::MemoryPointer.new(:float, @indexes.size * int_size)
      buffer.write_array_of_int(@indexes)

      index_ref = BGFX.make_ref(buffer, @indexes.size * int_size)
      @ibh = BGFX.create_index_buffer(index_ref, 0)
    end

    def unload
      GL.DeleteVertexArrays(1, [@vah].pack("L")) if @vah
      GL.DeleteBuffers(1, [@vbh].pack("L")) if @vbh
      GL.DeleteBuffers(1, [@ibh].pack("L")) if @ibh

      @vah = nil
      @vbh = nil
      @ibh = nil
    end
  end
end
