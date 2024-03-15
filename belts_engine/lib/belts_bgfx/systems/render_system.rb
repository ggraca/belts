module BeltsBGFX::Systems
  class RenderSystem < BeltsEngine::System
    phase :on_store

    query :cameras,
      with: [:position, :rotation, :camera]

    query :objects,
      with: [:transform_matrix, :render_data]

    def start
      BGFX.set_view_clear(0, BGFX::CLEAR_COLOR | BGFX::CLEAR_DEPTH, 0x443355FF, 1.0, 0)
      @u_color = BGFX.create_uniform("u_color", BGFX::UniformType[:Vec4], 1)
      @u_surface = BGFX.create_uniform("u_surface", BGFX::UniformType[:Vec4], 1)
      @s_tex_albedo = BGFX.create_uniform("s_tex_albedo", BGFX::UniformType[:Sampler], 1)
      @s_tex_normal = BGFX.create_uniform("s_tex_normal", BGFX::UniformType[:Sampler], 1)
      # BGFX.set_debug(BGFX::DEBUG_WIREFRAME)

      @game.bgfx_shaders.build_default_shader

      @game.assets.textures.each do |k, v|
        v.bgfx.load
      end

      @game.assets.meshes.each do |k, v|
        v.bgfx.load
      end
    end

    def update
      update_camera_data
      upload_object_data
      BGFX.frame(false)
    end

    private

    def update_camera_data
      cameras.each_with_components do |position:, rotation:|
        view_matrix = Mat4.look_at(position, position + rotation.forward, Vec3.up)
        proj_matrix = Mat4.perspective(Math::PI / 4, @window.ratio, 0.1, 100)

        BGFX.set_view_transform(0, view_matrix, proj_matrix)
        BGFX.touch(0)
      end
    end

    def upload_object_data
      objects.each_with_components do |transform_matrix:, render_data:|
        model = @assets.models[render_data.model]
        render_node(model.root_node, transform_matrix)
      end
    end

    def render_node(node, parent_transform)
      transform = parent_transform * node.transformation
      node.mesh_ids.each do |mesh_id|
        render_mesh(mesh_id, transform)
      end

      node.children.each do |child|
        render_node(child, transform)
      end
    end

    def render_mesh(mesh_name, transform)
      mesh = @assets.meshes[mesh_name]
      material = @assets.materials[mesh.material_id]

      BGFX.set_transform(transform, 1)
      BGFX.set_uniform(@u_color, material.color, 1)
      BGFX.set_uniform(@u_surface, material.surface, 1)

      BGFX.set_texture(0, @s_tex_albedo, @assets.textures[material.texture_ids[:albedo] || :default].bgfx.tbo, 0)

      BGFX.set_vertex_buffer(0, mesh.bgfx.vbo, 0, mesh.total_vertices)
      BGFX.set_index_buffer(mesh.bgfx.ebo, 0, mesh.total_elements)
      BGFX.set_state(BGFX::STATE_DEFAULT | BGFX::STATE_CULL_CCW, 1)
      BGFX.submit(0, @game.bgfx_shaders.get_shader(:default), 0, BGFX::DISCARD_ALL)
    end
  end
end
