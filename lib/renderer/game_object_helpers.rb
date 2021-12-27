require_relative './mesh_renderers/triangle'

module Renderer::GameObjectHelpers
  MESH_RENDERERS = {
    triangle: Renderer::MeshRenderers::Triangle,
  }

  def renderer(type, options = {})
    define_singleton_method :draw do
      MESH_RENDERERS[type]::draw(options)
    end
  end
end
