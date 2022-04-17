module Belts
  class Renderer
    def initialize(game)
      @game = game

      GLFW.load_lib()
      GLFW.Init()
      GLFW.WindowHint(GLFW::ALPHA_BITS, 0)
      @window = GLFW.CreateWindow(640, 480, "Belts Demo", nil, nil)
      GLFW.MakeContextCurrent(@window)

      # NOTE: This causes a segfault. Waiting for it to get fixed.
      # @input_manager = InputManager.new(@game, @window)

      GL.load_lib()
      GL.Enable(GL::DEPTH_TEST)
      GL.Enable(GL::CULL_FACE)
    end

    def update
      update_window_size
      GL.ClearColor(0.07, 0.13, 0.17, 1.0)
      GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
      GL.UseProgram(@game.asset_manager.get_shader(:default))

      render_entities

      GLFW.SwapBuffers(@window)
      GLFW.PollEvents()

      # @input_manager.update
    end

    private

    def update_window_size
      width_ptr = ' ' * 8
      height_ptr = ' ' * 8
      GLFW.GetFramebufferSize(@window, width_ptr, height_ptr)
      width = width_ptr.unpack('L')[0]
      height = height_ptr.unpack('L')[0]
      @window_ratio = width.to_f / height.to_f

      GL.Viewport(0, 0, width, height)
    end

    def render_entities
      camera_matrix = nil

      @game.entities.collection(with: [:transform, :camera_data]).each do |data|
        data => {transform:, camera_data:}

        # view_matrix = Mat4.look_at(transform.position, transform.position + transform.forward, transform.up)
        view_matrix = Mat4.rotation(*-transform.rotation) * Mat4.scale(1, 1, -1) * Mat4.translation(*-transform.position)
        proj_matrix = Mat4.perspective(45, @window_ratio, 0.1, 100)

        ortho_size = 5
        orth_matrix = Mat4.orthographic(-ortho_size * @window_ratio, ortho_size * @window_ratio, -ortho_size, ortho_size, 0, 10)

        camera_matrix = (proj_matrix * view_matrix)
      end

      @game.entities.collection(with: [:transform, :render_data]).each do |data|
        data => {transform:, render_data:}

        model_matrix = transform.to_matrix
        normal_matrix = model_matrix.inverse.transpose

        cameraLoc = GL.GetUniformLocation(@game.asset_manager.get_shader(:default), "camera_matrix")
        GL.UniformMatrix4fv(cameraLoc, 1, GL::FALSE, camera_matrix.transpose.to_a.flatten.pack("F*"))

        modelLoc = GL.GetUniformLocation(@game.asset_manager.get_shader(:default), "model_matrix")
        GL.UniformMatrix4fv(modelLoc, 1, GL::FALSE, model_matrix.transpose.to_a.flatten.pack("F*"))

        normalLoc = GL.GetUniformLocation(@game.asset_manager.get_shader(:default), "normal_matrix")
        GL.UniformMatrix4fv(normalLoc, 1, GL::FALSE, normal_matrix.transpose.to_a.flatten.pack("F*"))

        mesh = @game.asset_manager.get_mesh(render_data.type)
        mesh.draw
      end
    end
  end
end
