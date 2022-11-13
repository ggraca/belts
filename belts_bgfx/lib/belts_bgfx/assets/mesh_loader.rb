module BeltsBGFX::Assets
  class MeshLoader
    attr_reader :vah, :vbh, :ibh

    def initialize(vertices, indexes)
      @vert_buffer = FFI::MemoryPointer.new(:float, vertices.size)
      @vert_buffer.write_array_of_float(vertices)

      @index_buffer = FFI::MemoryPointer.new(:uint16, indexes.size)
      @index_buffer.write_array_of_type(:uint16, :put_uint16, indexes)

      @vah = BGFX::VertexLayout.new
      BGFX.vertex_layout_begin(@vah, 0)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Position], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Normal], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Color0], 4, BGFX::AttribType[:Float], true, false)
      BGFX.vertex_layout_end(@vah)

      unload
    end

    def load
      vertex_ref = BGFX.make_ref(@vert_buffer, @vert_buffer.size)
      @vbh = BGFX.create_vertex_buffer(vertex_ref, @vah, 0)

      index_ref = BGFX.make_ref(@index_buffer, @index_buffer.size)
      @ibh = BGFX.create_index_buffer(index_ref, 0)
    end

    # TODO: @vah?
    def unload
      BGFX.destroy_index_buffer(@ibh) if @ibh
      BGFX.destroy_vertex_buffer(@vbh) if @vbh

      @vbh = nil
      @ibh = nil
    end
  end
end
