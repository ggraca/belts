module BeltsOpenGL
  class AssetManager
    def initialize
      @shaders = {}

      build_default_shader
    end

    def get_shader(key)
      @shaders[key]
    end

    def build_default_shader
      vert_shader = GL.CreateShader(GL::VERTEX_SHADER)
      vpath = File.join(BeltsOpenGL.root, "lib/belts_opengl/assets/shaders/base.vert")
      vcontent = [File.read(vpath)].pack("p")
      vsize = [File.size(vpath)].pack("I")
      GL.ShaderSource(vert_shader, 1, vcontent, vsize)
      GL.CompileShader(vert_shader)

      frag_shader = GL.CreateShader(GL::FRAGMENT_SHADER)
      fpath = File.join(BeltsOpenGL.root, "lib/belts_opengl/assets/shaders/base.frag")
      fcontent = [File.read(fpath)].pack("p")
      fsize = [File.size(fpath)].pack("I")
      GL.ShaderSource(frag_shader, 1, fcontent, fsize)
      GL.CompileShader(frag_shader)

      @shaders[:default] = GL.CreateProgram()
      GL.AttachShader(@shaders[:default], vert_shader)
      GL.AttachShader(@shaders[:default], frag_shader)
      GL.LinkProgram(@shaders[:default])

      GL.DeleteShader(vert_shader)
      GL.DeleteShader(frag_shader)
    end
  end
end
