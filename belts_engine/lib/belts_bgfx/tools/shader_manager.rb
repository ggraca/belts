module BeltsBGFX
  module Tools
    class ShaderManager
      def initialize
        @shaders = {}
      end

      def get_shader(key)
        @shaders[key]
      end

      def build_default_shader
        shader_folder = File.join(BeltsBGFX.root, "lib/belts_bgfx/tools/shaders")

        # TODO: Build a task to this (e.g. belts build:shaders)
        # TODO: Build in a tmp folder
        # TODO: Allow this to work without bgfx-shaderc installed
        system "echo 'Building default shader...'"
        system "bgfx-shaderc -f #{shader_folder}/v_simple.sc -o #{shader_folder}/v_simple.bin --type v -i /usr/include/bgfx -p 440"
        system "bgfx-shaderc -f #{shader_folder}/f_simple.sc -o #{shader_folder}/f_simple.bin --type f -i /usr/include/bgfx -p 440"
        system "echo 'Default shader built!'"

        vertex = File.join(shader_folder, "v_simple.bin")
        fragment = File.join(shader_folder, "f_simple.bin")

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
