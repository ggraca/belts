module BeltsAssets
  extend BeltsSupport::Extension

  def self.install(game)
    game.register_tool(:assets, Tools::AssetManager.new)
  end

  def self.init(game)
    game.assets.reload(::Assets)
  end
end
