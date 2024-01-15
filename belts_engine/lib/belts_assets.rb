module BeltsAssets
  extend BeltsSupport::Extension

  def self.init(game)
    game.register_tool(:assets, Tools::AssetManager.new)
  end

  def self.late_init(game)
    game.assets.reload(::Assets)
  end
end
