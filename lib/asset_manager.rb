require_relative './meshes/triangle'
require_relative './meshes/square'
require_relative './meshes/cube'

class AssetManager
  def initialize
    @shaders = {}
    @meshes = {}

    build_default_shader
    build_default_meshes
  end

  def get_shader(key)
    @shaders[key]
  end

  def get_mesh(key)
    @meshes[key]
  end

  def build_default_shader
    vert_shader = glCreateShader(GL_VERTEX_SHADER)
    vpath = 'app/shaders/base.vert'
    vcontent = [File.read(vpath)].pack('p')
    vsize = [File.size(vpath)].pack('I')
    glShaderSource(vert_shader, 1, vcontent, vsize)
    glCompileShader(vert_shader)

    frag_shader = glCreateShader(GL_FRAGMENT_SHADER)
    fpath = 'app/shaders/base.frag'
    fcontent = [File.read(fpath)].pack('p')
    fsize = [File.size(fpath)].pack('I')
    glShaderSource(frag_shader, 1, fcontent, fsize)
    glCompileShader(frag_shader)

    @shaders[:default] = glCreateProgram()
    glAttachShader(@shaders[:default], vert_shader)
    glAttachShader(@shaders[:default], frag_shader)
    glLinkProgram(@shaders[:default])

    glDeleteShader(vert_shader)
    glDeleteShader(frag_shader)
  end

  def build_default_meshes
    default_meshes = {
      square: Meshes::Square.new,
      triangle: Meshes::Triangle.new,
      cube: Meshes::Cube.new
    }

    @meshes.merge!(default_meshes)
  end
end
