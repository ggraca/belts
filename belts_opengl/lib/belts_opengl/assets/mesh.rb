module BeltsOpengl::Assets
  module BufferHelpers
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
  end

  class Mesh
    include BufferHelpers

    U = 1.0 # Unit size
    HU = U / 2 # Half unit size

    def initialize(vertices, indexes)
      @vertices = vertices
      @indexes = indexes

      @vao = create_vertex_array_buffer
      @vbo = create_buffer
      @ebo = create_buffer

      upload_vertice_data
    end

    def draw
      GL.BindVertexArray(@vao)
      GL.DrawElements(GL::TRIANGLES, @indexes.size, GL::UNSIGNED_INT, @indexes.pack("L*"))
    end

    def destroy
      GL.DeleteVertexArrays(1, [@vao].pack("L"))
      GL.DeleteBuffers(1, [@vbo].pack("L"))
      GL.DeleteBuffers(1, [@ebo].pack("L"))
    end

    private

    def upload_vertice_data
      # values_per_vertex = 3

      GL.BindVertexArray(@vao)
      GL.BindBuffer(GL::ARRAY_BUFFER, @vbo)

      GL.BufferData(GL::ARRAY_BUFFER, @vertices.size * Fiddle::SIZEOF_FLOAT, @vertices.pack("F*"), GL::STATIC_DRAW)

      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, @ebo)
      GL.BufferData(GL::ELEMENT_ARRAY_BUFFER, @indexes.size * Fiddle::SIZEOF_INT, @indexes.pack("L*"), GL::STATIC_DRAW)

      GL.VertexAttribPointer(0, 3, GL::FLOAT, GL::FALSE, 6 * Fiddle::SIZEOF_FLOAT, 0)
      GL.VertexAttribPointer(1, 3, GL::FLOAT, GL::FALSE, 6 * Fiddle::SIZEOF_FLOAT, 3 * Fiddle::SIZEOF_FLOAT)
      GL.EnableVertexAttribArray(0)
      GL.EnableVertexAttribArray(1)

      GL.BindBuffer(GL::ARRAY_BUFFER, 0)
      GL.BindVertexArray(0)
      GL.BindBuffer(GL::ELEMENT_ARRAY_BUFFER, 0)
    end
  end
end
