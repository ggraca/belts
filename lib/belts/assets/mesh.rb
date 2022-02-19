module Belts::Assets
  module BufferHelpers
    private

    def create_buffer
      temp = ' ' * 4
      glGenBuffers(1, temp)
      temp.unpack('L')[0]
    end

    def create_vertex_array_buffer
      temp = ' ' * 4
      glGenVertexArrays(1, temp)
      temp.unpack('L')[0]
    end
  end

  class Mesh
    include BufferHelpers

    U = 1.0 # Unit size
    HU = U/2 # Half unit size

    def initialize(vertices, indexes)
      @vertices = vertices
      @indexes = indexes

      @vao = create_vertex_array_buffer
      @vbo = create_buffer
      @ebo = create_buffer

      upload_vertice_data
    end

    def draw
      glBindVertexArray(@vao)
      glDrawElements(GL_TRIANGLES, @indexes.size, GL_UNSIGNED_INT, 0)
    end

    def destroy
      glDeleteVertexArrays(1, [@vao].pack('L'))
      glDeleteBuffers(1, [@vbo].pack('L'))
      glDeleteBuffers(1, [@ebo].pack('L'))
    end

    private

    def upload_vertice_data
      values_per_vertex = 3

      glBindVertexArray(@vao)
      glBindBuffer(GL_ARRAY_BUFFER, @vbo)

      glBufferData(GL_ARRAY_BUFFER, @vertices.size * Fiddle::SIZEOF_FLOAT, @vertices.pack('F*'), GL_STATIC_DRAW)

      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, @ebo)
      glBufferData(GL_ELEMENT_ARRAY_BUFFER, @indexes.size * Fiddle::SIZEOF_INT, @indexes.pack('L*'), GL_STATIC_DRAW)

      glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * Fiddle::SIZEOF_FLOAT, 0)
      glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * Fiddle::SIZEOF_FLOAT, 3 * Fiddle::SIZEOF_FLOAT)
      glEnableVertexAttribArray(0)
      glEnableVertexAttribArray(1)

      glBindBuffer(GL_ARRAY_BUFFER, 0)
      glBindVertexArray(0)
      glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)
    end
  end
end
