module BeltsAssets
  extend BeltsSupport::Extension

  def self.install
    Assimp.load_lib
  end

  def self.init(game)
    game.register_tool(:assets, Tools::AssetManager.new)
    game.assets.reload(::Assets)
  end
end
