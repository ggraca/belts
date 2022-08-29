module BeltsBGFX
  class RenderSystem < BeltsEngine::System
    collection :objects,
      with: [:transform, :render_data]

    def start
      BGFX.set_view_rect(0, 0, 0, 640, 480)
      BGFX.set_view_clear(0, BGFX::CLEAR_COLOR | BGFX::CLEAR_DEPTH, 0x443355FF, 1.0, 0)
    end

    def update
      objects.each_with_components do |transform:, render_data:, **|
        mesh = @assets.meshes[render_data.mesh]

        BGFX.set_vertex_buffer(0, mesh[:bgfx].vbh, 0, mesh[:total_vertices])
        BGFX.set_index_buffer(mesh[:bgfx].ibh, 0, mesh[:total_indices])
      end

      BGFX.touch(0)
      BGFX.frame(false)
    end
  end
end
