module BeltsBGFX::Assets
  class MeshLoader
    attr_reader :vao, :vbo, :ebo, :total_vertices, :total_elements

    def initialize(mesh)
      @mesh = mesh
    end

    def load
      load_vertex_layout
      load_vertex_buffer(@mesh.vertices)
      load_index_buffer(@mesh.indices)

      @total_vertices = @mesh.vertices.size / 10
      @total_elements = @mesh.indices.size
    end

    def unload
      BGFX.destroy_vertex_layout(@vao) if @vao
      BGFX.destroy_index_buffer(@ebo) if @ebo
      BGFX.destroy_vertex_buffer(@vbo) if @vbo

      @vao = nil
      @vbo = nil
      @ebo = nil
    end

    private

    def load_vertex_layout
      @vao = BGFX::VertexLayout.new
      BGFX.vertex_layout_begin(@vao, 0)
      BGFX.vertex_layout_add(@vao, BGFX::Attrib[:Position], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vao, BGFX::Attrib[:Normal], 3, BGFX::AttribType[:Float], false, false)
      BGFX.vertex_layout_add(@vao, BGFX::Attrib[:Color0], 4, BGFX::AttribType[:Float], true, false)
      BGFX.vertex_layout_end(@vao)
    end

    def load_vertex_buffer(vertices)
      # TODO: Remove instance variables
      @vert_buffer = FFI::MemoryPointer.new(:float, vertices.size)
      @vert_buffer.write_array_of_float(vertices)

      vertex_ref = BGFX.make_ref(@vert_buffer, @vert_buffer.size)
      @vbo = BGFX.create_vertex_buffer(vertex_ref, @vao, 0)
    end

    def load_index_buffer(indices)
      @index_buffer = FFI::MemoryPointer.new(:uint16, indices.size)
      @index_buffer.write_array_of_type(:uint16, :put_uint16, indices)

      index_ref = BGFX.make_ref(@index_buffer, @index_buffer.size)
      @ebo = BGFX.create_index_buffer(index_ref, 0)
    end
  end
end
