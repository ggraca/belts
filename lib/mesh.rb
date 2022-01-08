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

  def initialize(vertices, indexes = [])
    @vertices = vertices
    @indexes = indexes

    @vao = create_vertex_array_buffer
    @vbo = create_buffer

    upload_vertice_data
  end

  def draw
    glBindVertexArray(@vao)
    glDrawArrays(GL_TRIANGLES, 0, @vertices.size)
  end

  def destroy
    glDeleteVertexArrays(1, [@vao].pack('L'))
    glDeleteBuffers(1, [@vbo].pack('L'))
  end

  private

  def upload_vertice_data
    values_per_vertex = 3
    flatten_vertices = @vertices.flatten

    glBindVertexArray(@vao)
    glBindBuffer(GL_ARRAY_BUFFER, @vbo)

    glBufferData(GL_ARRAY_BUFFER, flatten_vertices.size * Fiddle::SIZEOF_FLOAT, flatten_vertices.pack('f*'), GL_STATIC_DRAW)
    glVertexAttribPointer(0, values_per_vertex, GL_FLOAT, GL_FALSE, values_per_vertex * Fiddle::SIZEOF_FLOAT, 0)
    glEnableVertexAttribArray(0)

    glBindBuffer(GL_ARRAY_BUFFER, 0)
    glBindVertexArray(0)
  end
end
