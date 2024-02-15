module BeltsBGFX::Assets
  class TextureLoader
    attr_reader :tbo

    def initialize(texture)
      @texture = texture
    end

    def load
      load_texture_buffer
      # load_vertex_layout
      # load_vertex_buffer(@mesh.vertices)
      # load_index_buffer(@mesh.indices)

      # @total_vertices = @mesh.vertices.size / 10
      # @total_elements = @mesh.indices.size
    end

    def unload
      # BGFX.destroy_vertex_layout(@vao) if @vao
      # BGFX.destroy_index_buffer(@ebo) if @ebo
      # BGFX.destroy_vertex_buffer(@vbo) if @vbo

      # @vao = nil
      # @vbo = nil
      # @ebo = nil
    end

    private

    def load_texture_buffer
      @texture_buffer = FFI::MemoryPointer.new(:char, @texture.data.size)
      @texture_buffer.put_bytes(0, @texture.data)
      pp @texture_buffer.size # = 4194304

      texture_ref = BGFX.make_ref(@texture_buffer, @texture_buffer.size)
      @tbo = BGFX.create_texture_2d(@texture.width, @texture.height, false, 1, BGFX::TextureFormat[:RGBA8], BGFX::TEXTURE_NONE | BGFX::SAMPLER_NONE, texture_ref)
    end
  end
end
