include OpenGL
include GLFW

class Renderer
  def initialize(game)
    @game = game

    OpenGL.load_lib
    GLFW.load_lib

    glfwInit()
    glfwWindowHint(GLFW_ALPHA_BITS, 0)
    @window = glfwCreateWindow( 640, 480, "Belts Demo", nil, nil )
    glfwMakeContextCurrent( @window )
    glEnable(GL_DEPTH_TEST)
    glEnable(GL_CULL_FACE)
  end

  def update
    update_window_size
    glClearColor(0.07, 0.13, 0.17, 1.0)
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    glUseProgram(@game.asset_manager.get_shader(:default))

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

  def render_entities
    camera_matrix = nil

    @game.current_scene.collection(:transform, :camera_data).each do |data|
      data => {transform:, camera_data:}

      view_matrix = transform.to_matrix
      proj_matrix = Mat4.perspective(45, @window_ratio, 1, 100)
      orth_matrix = Mat4.orthographic(-@window_ratio * 10, @window_ratio * 10, -10, 10, 0, 100)

      camera_matrix = proj_matrix * view_matrix
    end

    @game.current_scene.collection(:transform, :render_data).each do |data|
      data => {transform:, render_data:}

      model_matrix = transform.to_matrix

      modelLoc = glGetUniformLocation(@game.asset_manager.get_shader(:default), "model")
      glUniformMatrix4fv(modelLoc, 1, GL_FALSE, model_matrix.transpose.to_a.flatten.pack("F*"))

      cameraLoc = glGetUniformLocation(@game.asset_manager.get_shader(:default), "camera")
      glUniformMatrix4fv(cameraLoc, 1, GL_FALSE, camera_matrix.transpose.to_a.flatten.pack("F*"))

      mesh = @game.asset_manager.get_mesh(render_data.type)
      mesh.draw
    end
  end
end
