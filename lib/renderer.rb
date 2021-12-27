include OpenGL
include GLFW

class Renderer
  def initialize
    OpenGL.load_lib
    GLFW.load_lib

    glfwInit()
    @window = glfwCreateWindow( 640, 480, "Simple example", nil, nil )
    glfwMakeContextCurrent( @window )
  end

  def set_current_scene(scene)
    @scene = scene
  end

  def update
    width_ptr = ' ' * 8
    height_ptr = ' ' * 8
    glfwGetFramebufferSize(@window, width_ptr, height_ptr)
    width = width_ptr.unpack('L')[0]
    height = height_ptr.unpack('L')[0]
    ratio = width.to_f / height.to_f

    glViewport(0, 0, width, height)
    glClear(GL_COLOR_BUFFER_BIT)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    glOrtho(-ratio, ratio, -1.0, 1.0, 1.0, -1.0)
    glMatrixMode(GL_MODELVIEW)

    @scene.renderers.each do |renderer|
      renderer.draw
    end

    glfwSwapBuffers( @window )
    glfwPollEvents()
  end
end
