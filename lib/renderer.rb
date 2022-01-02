require_relative './renderers/mesh_renderers/triangle'
require_relative './renderers/mesh_renderers/square'
require_relative './renderers/mesh_renderers/cube'

include OpenGL
include GLFW
include GLU

class Renderer
  MESH_RENDERERS = {
    triangle: Renderers::MeshRenderers::Triangle,
    square: Renderers::MeshRenderers::Square,
    cube: Renderers::MeshRenderers::Cube
  }

  def initialize
    OpenGL.load_lib
    GLFW.load_lib
    GLU.load_lib

    glfwInit()
    @window = glfwCreateWindow( 1920, 1080, "Simple example", nil, nil )
    glfwMakeContextCurrent( @window )
  end

  def set_current_scene(scene)
    @scene = scene
  end

  def update
    update_window_size
    glClear(GL_COLOR_BUFFER_BIT)

    update_cameras
    render_entities

    glfwSwapBuffers( @window )
    glfwPollEvents()
  end

  private

  def update_window_size
    width_ptr = ' ' * 8
    height_ptr = ' ' * 8
    glfwGetFramebufferSize(@window, width_ptr, height_ptr)
    width = width_ptr.unpack('L')[0]
    height = height_ptr.unpack('L')[0]
    @window_ratio = width.to_f / height.to_f

    glViewport(0, 0, width, height)
  end

  def update_cameras
    glMatrixMode(GL_PROJECTION)

    @scene.collection(:transform, :camera_data).each do |data|
      data => {transform:, camera_data:}

      glLoadIdentity()
      glTranslatef(*transform.position.values)
      gluPerspective(45.0, @window_ratio, 0.1, 1000.0) if camera_data.perspective?
      glOrtho(-@window_ratio, @window_ratio, -1.0, 1.0, 1.0, -1.0) if camera_data.orthographic?
    end

    glMatrixMode(GL_MODELVIEW)
  end

  def render_entities
    @scene.collection(:transform, :render_data).each do |data|
      data => {transform:, render_data:}

      MESH_RENDERERS[render_data.type]::draw(transform, data[:render_data])
    end
  end
end
