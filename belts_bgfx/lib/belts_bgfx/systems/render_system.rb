module BeltsBGFX
  class RenderSystem < BeltsEngine::System
    collection :cameras,
      with: [:position, :rotation, :camera]

    collection :objects,
      with: [:position, :rotation, :scale, :render_data]

    def start
      BGFX.set_view_clear(0, BGFX::CLEAR_COLOR | BGFX::CLEAR_DEPTH, 0x443355FF, 1.0, 0)
      @u_color = BGFX.create_uniform("u_color", BGFX::UniformType[:Vec4], 1)
      @u_surface = BGFX.create_uniform("u_surface", BGFX::UniformType[:Vec4], 1)
      # BGFX.set_debug(BGFX::DEBUG_WIREFRAME)
    end

    def update
      update_camera_data
      upload_object_data_new
      BGFX.frame(false)
    end

    private

    def update_camera_data
      cameras.each_with_components do |position:, rotation:, camera:, **|
        view_matrix = Mat4.look_at(position, position + rotation.forward, Vec3.up)
        proj_matrix = Mat4.perspective(Math::PI / 4, @window.ratio, 0.1, 100)

        BGFX.set_view_transform(0, view_matrix.as_glm, proj_matrix.as_glm)
        BGFX.touch(0)
      end
    end

    def upload_object_data
      objects.each_with_components do |position:, rotation:, scale:, render_data:,**|
        transform_matrix = TransformMatrix.new.tap do |dest|
          dest.set!(
            Mat4.translation(position) *
            Mat4.rotation(rotation) *
            Mat4.scale(scale)
          )
        end

        BGFX.set_transform(transform_matrix.as_glm, 1)
        render_model(render_data.model)
      end
    end

    def upload_object_data_new
      filter = Flecs.ecs_filter_init(
        @game.ecs.world,
        Flecs::FilterDesc.new.tap do |f|
          f[:terms][0] = Flecs::Term.new.tap do |t|
            t[:id] = @game.ecs.component(:position)
          end
          f[:terms][1] = Flecs::Term.new.tap do |t|
            t[:id] = @game.ecs.component(:rotation)
          end
          f[:terms][2] = Flecs::Term.new.tap do |t|
            t[:id] = @game.ecs.component(:scale)
          end
        end
      )

      it = Flecs.ecs_filter_iter(@game.ecs.world, filter)
      while(Flecs.ecs_filter_next(it))
        positions = Flecs.ecs_field_w_size(it, Position.size, 1)
        rotations = Flecs.ecs_field_w_size(it, Rotation.size, 2)
        scales = Flecs.ecs_field_w_size(it, Scale.size, 3)

        it[:count].times.each do |i|
          position = Position.new(positions[i * Position.size])
          rotation = Rotation.new(rotations[i * Rotation.size])
          scale = Scale.new(scales[i * Scale.size])

          transform_matrix = TransformMatrix.new.tap do |dest|
            dest.set!(
              Mat4.translation(position) *
              Mat4.rotation(rotation) *
              Mat4.scale(scale)
            )
          end

          BGFX.set_transform(transform_matrix.as_glm, 1)
          render_model(RenderData.new(:bunny, Vec3.right).model)
        end
      end
    end

    def render_model(model_name)
      model = @assets.models[model_name]
      render_node(model.root_node)
    end

    def render_node(node)
      # BGFX.set_transform(node.transformation.val, 1)
      node.mesh_ids.each do |mesh_id|
        render_mesh(mesh_id)
      end

      node.children.each do |child|
        render_node(child)
      end
    end

    def render_mesh(mesh_name)
      mesh = @assets.meshes[mesh_name]
      material = @assets.materials[mesh.material_id]

      BGFX.set_uniform(@u_color, material.color.as_glm, 1)
      BGFX.set_uniform(@u_surface, material.surface.as_glm, 1)
      BGFX.set_vertex_buffer(0, mesh.bgfx.vbo, 0, mesh.bgfx.total_vertices)
      BGFX.set_index_buffer(mesh.bgfx.ebo, 0, mesh.bgfx.total_elements)
      BGFX.set_state(BGFX::STATE_DEFAULT | BGFX::STATE_CULL_CCW, 1)
      BGFX.submit(0, @game.bgfx_shaders.get_shader(:default), 0, BGFX::DISCARD_ALL)
    end
  end
end
