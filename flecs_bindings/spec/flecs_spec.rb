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

      id = Flecs.ecs_entity_init(@world, Flecs::Entity.new)
      expect(Flecs.ecs_is_alive(@world, id)).to be true
    end

    specify 'component' do
      entity = Flecs.ecs_entity_init(@world, Flecs::Entity.new)
      component1 = Flecs.ecs_new_id(@world)
      component2 = Flecs.ecs_new_id(@world)

      Flecs.ecs_add_id(@world, entity, component1)
      expect(Flecs.ecs_has_id(@world, entity, component1)).to be true

      # TODO: how to define or access predefined components (structs)?
      # Flecs.ecs_set_id(world, entity, component2, 0, nil)
    end

    specify 'tag' do
      enemy_tag = Flecs.ecs_new_id(@world)
      entity = Flecs.ecs_new_id(@world)

      Flecs.ecs_add_id(@world, entity, enemy_tag)
      expect(Flecs.ecs_has_id(@world, entity, enemy_tag)).to be true

      Flecs.ecs_remove_id(@world, entity, enemy_tag)
      expect(Flecs.ecs_has_id(@world, entity, enemy_tag)).to be false
    end

    specify 'pair'
    specify 'hierarchy'
    specify 'instancing'
    specify 'type'
    specify 'singleton'
    specify 'filter'
    specify 'query'
    specify 'system'
    specify 'pipeline'
    specify 'observer'
    specify 'module'
  end
end
