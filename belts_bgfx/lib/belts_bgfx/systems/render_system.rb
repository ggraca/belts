module BeltsBGFX
  class RenderSystem < BeltsEngine::System
    collection :cameras,
      with: [:transform, :camera]

    collection :objects,
      with: [:transform, :render_data]

    def start
      BGFX.set_view_clear(0, BGFX::CLEAR_COLOR | BGFX::CLEAR_DEPTH, 0x443355FF, 1.0, 0)
    end

    def update
      cameras.each_with_components do |transform:, camera:, **|
        invert_z_axis_matrix = Mat4.scale(Vec3[1, 1, -1])

        view_matrix =
          invert_z_axis_matrix *
          Mat4.rotation(-transform.rotation) *
          Mat4.translation(-transform.position)

        proj_matrix = Mat4.perspective(45.0 * Math::PI / 180, @game.window.ratio, 0.1, 100)

        BGFX.set_view_transform(0, view_matrix.val, proj_matrix.val)
        BGFX.touch(0)
      end

      objects.each_with_components do |transform:, render_data:, **|
        mesh = @assets.meshes[render_data.mesh]

        BGFX.set_transform(transform.matrix.val, 1)
        BGFX.set_vertex_buffer(0, mesh[:bgfx].vbh, 0, mesh[:total_vertices] + 10000)
        BGFX.set_index_buffer(mesh[:bgfx].ibh, 0, mesh[:total_indices] + 10000)
        BGFX.set_state(BGFX::STATE_DEFAULT | BGFX::STATE_CULL_CCW | BGFX::STATE_PT_TRISTRIP , 0)
        BGFX.submit(0, default_shader, 0, 0)
      end

      BGFX.frame(false)
    end

    def default_shader
      @game.bgfx_shaders.get_shader(:default)
    end
  end
end
