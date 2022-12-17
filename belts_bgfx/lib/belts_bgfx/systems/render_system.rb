module BeltsBGFX
  class RenderSystem < BeltsEngine::System
    collection :cameras,
      with: [:transform, :camera]

    collection :objects,
      with: [:transform, :render_data]

    def start
      BGFX.set_view_clear(0, BGFX::CLEAR_COLOR | BGFX::CLEAR_DEPTH, 0x443355FF, 1.0, 0)
      # BGFX.set_debug(BGFX::DEBUG_WIREFRAME)
    end

    def update
      update_camera_data
      upload_object_data
      BGFX.frame(false)
    end

    private

    def update_camera_data
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
    end

    def upload_object_data
      objects.each_with_components do |transform:, render_data:, **|
        BGFX.set_transform(transform.matrix.val, 1)
        render_model(render_data.model)
      end
    end

    def render_model(model_name)
      model = @assets.models[model_name]
      model[:meshes].each do |mesh|
        render_mesh(mesh)
      end
    end

    def render_mesh(mesh_name)
      mesh = @assets.meshes[mesh_name]
      BGFX.set_vertex_buffer(0, mesh[:bgfx].vbh, 0, mesh[:total_vertices] / 10)
      BGFX.set_index_buffer(mesh[:bgfx].ibh, 0, mesh[:total_indices])
      BGFX.set_state(BGFX::STATE_DEFAULT | BGFX::STATE_CULL_CW, 1)
      BGFX.submit(0, @game.bgfx_shaders.get_shader(:default), 0, 0)
    end
  end
end
