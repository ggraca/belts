require "bgfx"
require "sdl2"

module BeltsBGFX
  extend BeltsSupport::Extension

  def self.install
    # TODO: Automatically find the lib based on the platform
    SDL.load_lib("libSDL2.so")

    BeltsAssets::Mesh.include BeltsBGFX::Assets::MeshMixin
  end

  def self.root
    File.dirname __dir__
  end
end
