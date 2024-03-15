module BeltsBGFX::Assets
  class TextureLoader
    attr_reader :tbo

    def initialize(texture)
      @texture = texture
    end

    def load
      load_texture_buffer
    end

    def unload
      # BGFX.destroy_vertex_buffer(@vbo) if @vbo

      # @vbo = nil
    end

    private

    def load_texture_buffer
      @texture_buffer = FFI::MemoryPointer.new(:char, @texture.data.size)
      @texture_buffer.put_bytes(0, @texture.data)

      texture_ref = BGFX.make_ref(@texture_buffer, @texture_buffer.size)
      @tbo = BGFX.create_texture_2d(@texture.width, @texture.height, false, 1, BGFX::TextureFormat[:RGBA8], BGFX::TEXTURE_NONE | BGFX::SAMPLER_NONE, texture_ref)
    end
  end
end
