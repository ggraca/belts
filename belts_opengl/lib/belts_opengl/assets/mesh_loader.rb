module BeltsOpenGL::Assets
  class MeshLoader
    attr_reader :vao, :vbo, :ebo

    def initialize(vertices, indexes)
      @vertices = vertices
      @indexes = indexes

      unload
    end

    def load
      @vao = create_vertex_array_buffer
      @vbo = create_buffer
      @ebo = create_buffer

      upload_vertice_data
    end

    def unload
      GL.DeleteVertexArrays(1, [@vao].pack("L")) if @vao
      GL.DeleteBuffers(1, [@vbo].pack("L")) if @vbo
      GL.DeleteBuffers(1, [@ebo].pack("L")) if @ebo

      @vao = nil
      @vbo = nil
      @ebo = nil
    end

    private

    def create_buffer
      temp = " " * 4
      GL.GenBuffers(1, temp)
      temp.unpack1("L")
    end

    def create_vertex_array_buffer
      temp = " " * 4
      GL.GenVertexArrays(1, temp)
      temp.unpack1("L")
    end

    def upload_vertice_data
      GL.BindVertexArray(@vao)
      GL.BindBuffer(GL::ARRAY_BUFFER, @vbo)

      GL.BufferData(GL::ARRAY_BUFFER, @vertices.size * Fiddle::SIZEOF_FLOAT, @vertices.pack("F*"), GL::STATIC_DRAW)

      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, @ebo)
      GL.BufferData(GL::ELEMENT_ARRAY_BUFFER, @indexes.size * Fiddle::SIZEOF_INT, @indexes.pack("L*"), GL::STATIC_DRAW)

      stride = 3 * Fiddle::SIZEOF_FLOAT + 3 * Fiddle::SIZEOF_FLOAT + 4 * Fiddle::SIZEOF_FLOAT

      # Vertices
      GL.VertexAttribPointer(0, 3, GL::FLOAT, GL::FALSE, stride, 0)
      # Normals
      GL.VertexAttribPointer(1, 3, GL::FLOAT, GL::FALSE, stride, 3 * Fiddle::SIZEOF_FLOAT)
      # Colors
      GL.VertexAttribPointer(2, 4, GL::FLOAT, GL::FALSE, stride, 7 * Fiddle::SIZEOF_FLOAT)

      GL.EnableVertexAttribArray(0)
      GL.EnableVertexAttribArray(1)

      GL.BindBuffer(GL::ARRAY_BUFFER, 0)
      GL.BindVertexArray(0)
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, 0)
    end
  end
end
