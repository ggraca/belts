module BeltsOpengl
  class RenderSystem < BeltsEngine::System
    collection :cameras,
      with: [:transform, :camera_data]

    collection :objects,
      with: [:transform, :render_data]

    def start
      GL.Enable(GL::DEPTH_TEST)
      GL.Enable(GL::CULL_FACE)
    end

    def update
      GL.ClearColor(0.07, 0.13, 0.17, 1.0)
      GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
      GL.UseProgram(default_shader)

      render_entities
    end

    private

    def render_entities
      camera_matrix = nil

      cameras.each_with_components do |transform:, _camera_data:, **|
        # view_matrix = Mat4.look_at(transform.position, transform.position + transform.forward, transform.up)
        view_matrix = Mat4.rotation(*-transform.rotation) * Mat4.scale(1, 1, -1) * Mat4.translation(*-transform.position)
        proj_matrix = Mat4.perspective(45, @game.window.ratio, 0.1, 100)

        # ortho_size = 5
        # orth_matrix = Mat4.orthographic(-ortho_size * @game.window.ratio, ortho_size * @game.window.ratio, -ortho_size, ortho_size, 0, 10)

        camera_matrix = (proj_matrix * view_matrix)
      end

      objects.each_with_components do |transform:, render_data:, **|
        model_matrix = transform.to_matrix
        normal_matrix = model_matrix.inverse.transpose

        camera_loc = GL.GetUniformLocation(default_shader, "camera_matrix")
        GL.UniformMatrix4fv(camera_loc, 1, GL::FALSE, camera_matrix.transpose.to_a.flatten.pack("F*"))

        model_loc = GL.GetUniformLocation(default_shader, "model_matrix")
        GL.UniformMatrix4fv(model_loc, 1, GL::FALSE, model_matrix.transpose.to_a.flatten.pack("F*"))

        normal_loc = GL.GetUniformLocation(default_shader, "normal_matrix")
        GL.UniformMatrix4fv(normal_loc, 1, GL::FALSE, normal_matrix.transpose.to_a.flatten.pack("F*"))

        mesh = @game.asset_manager.get_mesh(render_data.type)
        mesh.draw
      end
    end

    def default_shader
      @game.asset_manager.get_shader(:default)
    end
  end
end
