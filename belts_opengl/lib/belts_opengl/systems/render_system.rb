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
      flatten_camera_matrix = camera_matrix.transpose.to_a.flatten.pack("F*")

      objects.each_with_components do |transform:, render_data:, **|
        camera_loc = GL.GetUniformLocation(default_shader, "camera_matrix")
        GL.UniformMatrix4fv(camera_loc, 1, GL::FALSE, flatten_camera_matrix)

        model_loc = GL.GetUniformLocation(default_shader, "model_matrix")
        GL.UniformMatrix4fv(model_loc, 1, GL::FALSE, transform.flatten_matrix)

        normal_loc = GL.GetUniformLocation(default_shader, "normal_matrix")
        GL.UniformMatrix4fv(normal_loc, 1, GL::FALSE, transform.flatten_normal_matrix)

        mesh = @game.asset_manager.get_mesh(render_data.type)
        mesh.draw
      end
    end

    def default_shader
      @game.asset_manager.get_shader(:default)
    end

    def camera_matrix
      cameras.each_with_components do |transform:, camera_data:, **|
        view_matrix = Mat4.rotation(-transform.rotation) * Mat4.scale(Vec3[1, 1, -1]) * Mat4.translation(-transform.position)
        proj_matrix = Mat4.perspective(45, @game.window.ratio, 0.1, 100)

        return (proj_matrix * view_matrix)
      end
    end
  end
end
