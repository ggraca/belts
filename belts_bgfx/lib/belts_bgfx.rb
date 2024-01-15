require "belts_engine"
require "bgfx"
require "sdl2"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "belts_bgfx" => "BeltsBGFX"
loader.setup

module BeltsBGFX
  extend BeltsSupport::Extension

  def self.install
    require "belts_bgfx/systems/window_system"
    require "belts_bgfx/systems/render_system"

    # TODO: Automatically find the lib based on the platform
    SDL.load_lib("libSDL2.so")

    BeltsAssets::Mesh.include BeltsBGFX::Assets::MeshMixin
  end

  def self.init(game)
    game.systems.register_system(BeltsBGFX::WindowSystem)
    game.systems.register_system(BeltsBGFX::RenderSystem)

    # TODO: remove loader logic: game.assets.meshes.register_loader(:bgfx, BeltsBGFX::Assets::MeshLoader)
    game.register_tool(:bgfx_shaders, BeltsBGFX::Tools::ShaderManager.new)
  end

  def self.root
    File.dirname __dir__
  end
end
