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

      # view_matrix = Mat4.look_at(transform.position, transform.position + transform.forward, transform.up)
      view_matrix = Mat4.rotation(*-transform.rotation) * Mat4.scale(1, 1, -1) * Mat4.translation(*-transform.position)
      proj_matrix = Mat4.perspective(45, @window_ratio, 0.1, 100)

      ortho_size = 5
      orth_matrix = Mat4.orthographic(-ortho_size * @window_ratio, ortho_size * @window_ratio, -ortho_size, ortho_size, 0, 10)

      camera_matrix = (proj_matrix * view_matrix)
    end

    @game.current_scene.collection(:transform, :render_data).each do |data|
      data => {transform:, render_data:}

      model_matrix = transform.to_matrix
      normal_matrix = model_matrix.inverse.transpose

      cameraLoc = glGetUniformLocation(@game.asset_manager.get_shader(:default), "camera_matrix")
      glUniformMatrix4fv(cameraLoc, 1, GL_FALSE, camera_matrix.transpose.to_a.flatten.pack("F*"))

      modelLoc = glGetUniformLocation(@game.asset_manager.get_shader(:default), "model_matrix")
      glUniformMatrix4fv(modelLoc, 1, GL_FALSE, model_matrix.transpose.to_a.flatten.pack("F*"))

      normalLoc = glGetUniformLocation(@game.asset_manager.get_shader(:default), "normal_matrix")
      glUniformMatrix4fv(normalLoc, 1, GL_FALSE, normal_matrix.transpose.to_a.flatten.pack("F*"))

      mesh = @game.asset_manager.get_mesh(render_data.type)
      mesh.draw
    end
  end
end
