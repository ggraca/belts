module BeltsCore
  extend BeltsSupport::Extension

  def self.init(game)
    game.register_tool(:input, Tools::Input.new)
    game.register_tool(:window, Tools::Window.new)
  end
end
