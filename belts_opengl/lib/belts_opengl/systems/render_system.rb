module BeltsOpenGL
  class RenderSystem < BeltsEngine::System
    collection :cameras,
      with: [:transform, :camera]

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

      upload_camera_data
      upload_object_data
    end

    private

    def upload_camera_data
      cameras.each_with_components do |transform:, camera:, **|
        invert_z_axis_matrix = Mat4.scale(Vec3[1, 1, -1])

        view_matrix =
          invert_z_axis_matrix *
          Mat4.rotation(-transform.rotation) *
          Mat4.translation(-transform.position)

        proj_matrix = Mat4.perspective(45.0 * Math::PI / 180, @game.window.ratio, 0.1, 100)

        vp_matrix_loc = GL.GetUniformLocation(default_shader, "vp_matrix")
        GL.UniformMatrix4fv(vp_matrix_loc, 1, GL::FALSE, (proj_matrix * view_matrix).val.to_ptr.address)

        camera_pos_loc = GL.GetUniformLocation(default_shader, "camera_position")
        GL.Uniform3f(camera_pos_loc, 1, GL::FALSE, transform.position.val.to_ptr.address)
      end
    end

    def upload_object_data
      objects.each_with_components do |transform:, render_data:, **|
        model_matrix_addr = transform.matrix.val.to_ptr.address

        model_loc = GL.GetUniformLocation(default_shader, "model_matrix")
        GL.UniformMatrix4fv(model_loc, 1, GL::FALSE, model_matrix_addr)

        mesh = @assets.meshes[render_data.type]
        GL.BindVertexArray(mesh[:opengl].vao)
        GL.DrawElements(GL::TRIANGLES, mesh[:total_indices], GL::UNSIGNED_INT, 0)
      end
    end

    def default_shader
      @game.asset_manager.get_shader(:default)
    end
  end
end
