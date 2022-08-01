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
      camera_matrix_addr = camera_matrix.val.to_ptr.address

      objects.each_with_components do |transform:, render_data:, **|
        model_matrix_addr = transform.matrix.val.to_ptr.address
        normal_matrix_addr = transform.matrix.inverse.val.to_ptr.address

        camera_loc = GL.GetUniformLocation(default_shader, "camera_matrix")
        GL.UniformMatrix4fv(camera_loc, 1, GL::FALSE, camera_matrix_addr)

        model_loc = GL.GetUniformLocation(default_shader, "model_matrix")
        GL.UniformMatrix4fv(model_loc, 1, GL::FALSE, model_matrix_addr)

        normal_loc = GL.GetUniformLocation(default_shader, "normal_matrix")
        GL.UniformMatrix4fv(normal_loc, 1, GL::FALSE, normal_matrix_addr)

        mesh = @game.asset_manager.get_mesh(render_data.type)
        mesh.draw
      end
    end

    def default_shader
      @game.asset_manager.get_shader(:default)
    end

    def camera_matrix
      cameras.each_with_components do |transform:, camera_data:, **|
        invert_z_axis_matrix = Mat4.scale(Vec3[1, 1, -1])

        view_matrix =
          invert_z_axis_matrix *
          Mat4.rotation(-transform.rotation) *
          Mat4.translation(-transform.position)

        proj_matrix = Mat4.perspective(45.0 * Math::PI / 180, @game.window.ratio, 0.1, 100)

        return proj_matrix * view_matrix
      end
    end
  end
end
