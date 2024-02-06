require "bgfx"
require "sdl2"

module BeltsBGFX
  extend BeltsSupport::Extension

  config_accessor :bgfx_lib_path, default: :libbgfx
  config_accessor :sdl_lib_path, default: "libSDL2.so"

  def self.install
    BGFX.load_lib(config.bgfx_lib_path)

    # TODO: Automatically find the lib based on the platform
    SDL.load_lib(config.sdl_lib_path)

    BeltsAssets::Mesh.include BeltsBGFX::Assets::MeshMixin
  end

  def self.root
    File.dirname __dir__
  end
end
