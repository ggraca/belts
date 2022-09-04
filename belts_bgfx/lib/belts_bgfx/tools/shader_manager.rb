module BeltsBGFX
  module Tools
    class ShaderManager
      def initialize
        @shaders = {}

        build_default_shader
      end

      def get_shader(key)
        @shaders[key]
      end

      def build_default_shader
        vertex = File.join(BeltsBGFX.root, "lib/belts_bgfx/tools/shaders/v_simple.bin")
        fragment = File.join(BeltsBGFX.root, "lib/belts_bgfx/tools/shaders/f_simple.bin")

        @shaders[:default] = BGFX.create_program(
          load_shader(vertex),
          load_shader(fragment),
          true
        )
      end

      private

      def load_shader(path)
        content = File.read(path)

        buffer = FFI::MemoryPointer.new(:char, content.bytesize)
        buffer.put_bytes(0, content)

        mem = BGFX.copy(buffer, content.bytesize)

        BGFX.create_shader(mem)
      end
    end
  end
end
