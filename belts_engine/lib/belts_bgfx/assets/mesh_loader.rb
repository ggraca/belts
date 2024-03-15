module BeltsBGFX::Assets
  class MeshLoader
    attr_reader :vao, :vbo, :ebo

    def initialize(mesh)
      @mesh = mesh
    end

    def load
      load_vertex_layout
      load_vertex_buffer
      load_index_buffer
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

      if @mesh.colors.any?
        BGFX.vertex_layout_add(@vao, BGFX::Attrib[:Color0], 4, BGFX::AttribType[:Float], true, false)
      end

      if @mesh.texture_coords.any?
        BGFX.vertex_layout_add(@vao, BGFX::Attrib[:TexCoord0], 3, BGFX::AttribType[:Float], false, false)
      end

      BGFX.vertex_layout_end(@vao)
    end

    def load_vertex_buffer
      vertices = Array.new(@mesh.positions.size) do |i|
        [*@mesh.positions[i], *@mesh.normals[i], *@mesh.colors[i], *@mesh.texture_coords[i]]
      end.flatten

      # TODO: Remove instance variables, perhaps with blocking: true on the function call
      @vert_buffer = FFI::MemoryPointer.new(:float, vertices.size)
      @vert_buffer.write_array_of_float(vertices)

      vertex_ref = BGFX.make_ref(@vert_buffer, @vert_buffer.size)
      @vbo = BGFX.create_vertex_buffer(vertex_ref, @vao, 0)
    end

    def load_index_buffer
      @index_buffer = FFI::MemoryPointer.new(:uint16, @mesh.total_elements)
      @index_buffer.write_array_of_type(:uint16, :put_uint16, @mesh.indices)

      index_ref = BGFX.make_ref(@index_buffer, @index_buffer.size)
      @ebo = BGFX.create_index_buffer(index_ref, 0)
    end
  end
end
