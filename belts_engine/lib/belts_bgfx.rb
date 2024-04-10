require "bgfx"
require "sdl2"

module BeltsBGFX
  extend BeltsSupport::Extension

  config_accessor :bgfx_lib_path, default: :libbgfx
  config_accessor :sdl_lib_path, default: "libSDL2.so"

  def self.install
    BGFX.load_lib(config.bgfx_lib_path)
    SDL.load_lib(config.sdl_lib_path)

    BeltsAssets::Mesh.include BeltsBGFX::Assets::MeshMixin
    BeltsAssets::Texture.include BeltsBGFX::Assets::TextureMixin
  end

  def self.init(game)
    game.register_tool(:bgfx_shaders, BeltsBGFX::Tools::ShaderManager.new)
  end

  def self.root
    File.dirname __dir__
  end
end
