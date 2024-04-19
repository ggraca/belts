require "assimp"
require "rmagick"

module BeltsAssets
  extend BeltsSupport::Extension

  config_accessor :assimp_lib_path, default: :libassimp
  config_accessor :models, default: {}
  config_accessor :sprites, default: {}

  def self.install
    Assimp.load_lib(config.assimp_lib_path)
  end

  def self.init(game)
    game.register_tool(:assets, Tools::AssetManager.new)
    game.assets.load_sprites(config.sprites)
    game.assets.load_models(config.models)
  end
end
