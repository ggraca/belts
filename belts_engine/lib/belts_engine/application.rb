module BeltsEngine
  class Application
    include BeltsSupport::Configuration

    config.plugins = []

    def initialize
      @game = Belts::Game.new

      config.plugins.each do |plugin_class|
        @game.use plugin_class
      end

      @game.load_assets
      @game.start

      while true
        @game.update
      end
    end
  end
end
