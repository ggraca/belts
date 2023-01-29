module BeltsBGFX::Assets
  class MeshLoader
    attr_reader :vah, :vbh, :ibh

    def initialize(mesh)
      @mesh = mesh
    end

    def load
      load_vertex_layout
      load_vertex_buffer(@mesh.vertices)
      load_index_buffer(@mesh.indices)
    end

    # TODO: @vah?
    def unload
      BGFX.destroy_index_buffer(@ibh) if @ibh
      BGFX.destroy_vertex_buffer(@vbh) if @vbh

      @vbh = nil
      @ibh = nil
    end

    private

    def load_vertex_layout
      @vah = BGFX::VertexLayout.new
      BGFX.vertex_layout_begin(@vah, 0)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Position], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Normal], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vah, BGFX::Attrib[:Color0], 4, BGFX::AttribType[:Float], true, false)
      BGFX.vertex_layout_end(@vah)
    end

    def load_vertex_buffer(vertices)
      # TODO: Remove instance variables
      @vert_buffer = FFI::MemoryPointer.new(:float, vertices.size)
      @vert_buffer.write_array_of_float(vertices)

      vertex_ref = BGFX.make_ref(@vert_buffer, @vert_buffer.size)
      @vbh = BGFX.create_vertex_buffer(vertex_ref, @vah, 0)
    end

    def load_index_buffer(indices)
      @index_buffer = FFI::MemoryPointer.new(:uint16, indices.size)
      @index_buffer.write_array_of_type(:uint16, :put_uint16, indices)

      index_ref = BGFX.make_ref(@index_buffer, @index_buffer.size)
      @ibh = BGFX.create_index_buffer(index_ref, 0)
    end
  end
end
