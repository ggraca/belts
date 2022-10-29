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
      BGFX.vertex_layout_begin(@vah, 0)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Position], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Normal], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_end(@vah)

      vert_buffer = FFI::MemoryPointer.new(:float, @vertices.size)
      vert_buffer.write_array_of_float(@vertices)

      vertex_ref = BGFX.make_ref(vert_buffer, vert_buffer.size)
      @vbh = BGFX.create_vertex_buffer(vertex_ref, @vah, 0)

      index_buffer = FFI::MemoryPointer.new(:int, @indexes.size)
      index_buffer.write_array_of_int(@indexes)

      index_ref = BGFX.make_ref(index_buffer, index_buffer.size)
      @ibh = BGFX.create_index_buffer(index_ref, 0)
    end

    # TODO
    def unload
      BGFX.destroy_index_buffer(@ibh) if @ibh
      BGFX.destroy_vertex_buffer(@vbh) if @vbh

      @vah = nil
      @vbh = nil
      @ibh = nil
    end
  end
end
