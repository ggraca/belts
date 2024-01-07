require 'spec_helper'

describe Flecs do
  specify 'world' do
    world = Flecs.ecs_init
    Flecs.ecs_fini(world)
  end

  context 'with world' do
    around do |example|
      @world = Flecs.ecs_init
      example.run
      Flecs.ecs_fini(@world)
    end

    specify 'entity' do
      id = Flecs.ecs_new_id(@world)
      expect(Flecs.ecs_is_alive(@world, id)).to be true
      Flecs.ecs_delete(@world, id)
      expect(Flecs.ecs_is_alive(@world, id)).to be false

      id = Flecs.ecs_entity_init(@world, Flecs::EntityDesc.new)
      expect(Flecs.ecs_is_alive(@world, id)).to be true
    end

    specify 'component' do
      position = Flecs.ecs_component_init(
        @world,
        Flecs::ComponentDesc.new.tap do |component|
          component[:type][:name] = FFI::MemoryPointer.from_string('Position')
          component[:type][:size] = 8
          component[:type][:alignment] = 4
        end
      )

      velocity = Flecs.ecs_component_init(
        @world,
        Flecs::ComponentDesc.new.tap do |component|
          component[:type][:name] = FFI::MemoryPointer.from_string('Velocity')
          component[:type][:size] = 8
          component[:type][:alignment] = 4
        end
      )

      entity = Flecs.ecs_entity_init(@world, Flecs::EntityDesc.new)
      Flecs.ecs_add_id(@world, entity, position)
      expect(Flecs.ecs_has_id(@world, entity, position)).to be true

      position_buffer = FFI::MemoryPointer.new(:float, 2)
      position_buffer.write_array_of_float([2.1, 5.2])
      Flecs.ecs_set_id(@world, entity, position, 8, position_buffer)
      expect(Flecs.ecs_has_id(@world, entity, position)).to be true

      velocity_buffer = FFI::MemoryPointer.new(:float, 2)
      velocity_buffer.write_array_of_float([2.1, 5.2])
      Flecs.ecs_set_id(@world, entity, velocity, 8, velocity_buffer)
      expect(Flecs.ecs_has_id(@world, entity, velocity)).to be true

      # NOTE: writting to a buffer will cause a float to be inacurate
      val = Flecs.ecs_get_id(@world, entity, position).read_array_of_float(2)
      expect([val[0].round(6), val[1].round(6)]).to eq([2.1, 5.2])

      Flecs.ecs_remove_id(@world, entity, position)
      expect(Flecs.ecs_has_id(@world, entity, position)).to be false
    end

    specify 'tag' do
      enemy_tag = Flecs.ecs_new_id(@world)
      entity = Flecs.ecs_new_id(@world)

      Flecs.ecs_add_id(@world, entity, enemy_tag)
      expect(Flecs.ecs_has_id(@world, entity, enemy_tag)).to be true

      Flecs.ecs_remove_id(@world, entity, enemy_tag)
      expect(Flecs.ecs_has_id(@world, entity, enemy_tag)).to be false
    end

    specify 'pair' do
      likes = Flecs.ecs_new_id(@world)
      bob = Flecs.ecs_new_id(@world)
      alice = Flecs.ecs_new_id(@world)

      likes_alice = Flecs.ecs_make_pair(likes, alice)
      likes_bob = Flecs.ecs_make_pair(likes, bob)

      Flecs.ecs_add_id(@world, bob, likes_alice)
      Flecs.ecs_add_id(@world, alice, likes_bob)

      expect(Flecs.ecs_has_id(@world, bob, likes_alice)).to be true
      expect(Flecs.ecs_has_id(@world, alice, likes_bob)).to be true

      Flecs.ecs_remove_id(@world, bob, likes_alice)
      expect(Flecs.ecs_has_id(@world, bob, likes_alice)).to be false
      expect(Flecs.ecs_has_id(@world, alice, likes_bob)).to be true
    end

    specify 'hierarchy'
    specify 'instancing'
    specify 'type'
    specify 'singleton'

    specify 'filter' do
      position = Flecs.ecs_component_init(
        @world,
        Flecs::ComponentDesc.new.tap do |component|
          component[:type][:name] = FFI::MemoryPointer.from_string('Position')
          component[:type][:size] = 8
          component[:type][:alignment] = 4
        end
      )

      filter = Flecs::FilterDesc.new.tap do |f|
        f[:terms][0] = Flecs::Term.new.tap do |t|
          t[:id] = position
        end
      end
      filter_ptr = Flecs.ecs_filter_init(@world, filter)

      # TODO: get iterator
      # Flecs.ecs_filter_fini(filter)
    end

    specify 'query'
    specify 'system'
    specify 'pipeline'
    specify 'observer'
    specify 'module'
  end
end
