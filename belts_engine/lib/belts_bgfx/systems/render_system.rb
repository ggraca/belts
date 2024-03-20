module BeltsBGFX::Systems
  class RenderSystem < BeltsEngine::System
    MAX_LIGHTS = 512

    phase :on_store

    query :cameras,
      with: [:position, :rotation, :camera]

    query :lights,
      with: [:position, :light]

    query :objects,
      with: [:transform_matrix, :render_data]

    def start
      BGFX.set_view_clear(0, BGFX::CLEAR_COLOR | BGFX::CLEAR_DEPTH, 0x443355FF, 1.0, 0)

      # NOTE: x = total lights
      @u_lights = BGFX.create_uniform("u_lights", BGFX::UniformType[:Vec4], 1)
      @u_light_positions = BGFX.create_uniform("u_light_positions", BGFX::UniformType[:Vec4], MAX_LIGHTS)
      @u_light_colors = BGFX.create_uniform("u_light_colors", BGFX::UniformType[:Vec4], MAX_LIGHTS)

      @u_color = BGFX.create_uniform("u_color", BGFX::UniformType[:Vec4], 1)
      @u_surface = BGFX.create_uniform("u_surface", BGFX::UniformType[:Vec4], 1)
      @s_tex_albedo = BGFX.create_uniform("s_tex_albedo", BGFX::UniformType[:Sampler], 1)
      @s_tex_normals = BGFX.create_uniform("s_tex_normals", BGFX::UniformType[:Sampler], 1)
      @s_tex_roughness = BGFX.create_uniform("s_tex_roughness", BGFX::UniformType[:Sampler], 1)
      @s_tex_metalness = BGFX.create_uniform("s_tex_metalness", BGFX::UniformType[:Sampler], 1)
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
      upload_camera_data
      upload_light_data
      upload_object_data
      BGFX.frame(false)
    end

    private

    def upload_camera_data
      cameras.each_with_components do |position:, rotation:|
        view_matrix = Mat4.look_at(position, position + rotation.forward, Vec3.up)
        proj_matrix = Mat4.perspective(Math::PI / 4, @window.ratio, 0.1, 100)

        BGFX.set_view_transform(0, view_matrix, proj_matrix)
        BGFX.touch(0)
      end
    end

    def upload_light_data
      total = lights.size
      BGFX.set_uniform(@u_lights, Vec4[total, 0, 0, 0], 1)

      positions_buffer = FFI::MemoryPointer.new(:float, total * 4)
      colors_buffer = FFI::MemoryPointer.new(:float, total * 4)

      i = 0
      lights.each_with_components do |position:, light:|
        positions_buffer.put_array_of_float(i * 4, position[:values].to_a + [0])
        colors_buffer.put_array_of_float(i * 4, [light[:r], light[:g], light[:b], 0])

        i += 1
      end

      BGFX.set_uniform(@u_light_positions, positions_buffer, total)
      BGFX.set_uniform(@u_light_colors, colors_buffer, total)
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
      BGFX.set_texture(1, @s_tex_normals, @assets.textures[material.texture_ids[:normals] || :default].bgfx.tbo, 0)
      BGFX.set_texture(2, @s_tex_roughness, @assets.textures[material.texture_ids[:roughness] || :default].bgfx.tbo, 0)
      BGFX.set_texture(3, @s_tex_metalness, @assets.textures[material.texture_ids[:metalness] || :default].bgfx.tbo, 0)

      BGFX.set_vertex_buffer(0, mesh.bgfx.vbo, 0, mesh.total_vertices)
      BGFX.set_index_buffer(mesh.bgfx.ebo, 0, mesh.total_elements)
      BGFX.set_state(BGFX::STATE_DEFAULT | BGFX::STATE_CULL_CCW, 1)
      BGFX.submit(0, @game.bgfx_shaders.get_shader(:default), 0, BGFX::DISCARD_ALL)
    end
  end
end
