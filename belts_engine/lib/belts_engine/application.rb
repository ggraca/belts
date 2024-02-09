module BeltsEngine
  # The application ensures all libraries are loaded before starting the game.
  # It can also handle some pre-processing (e.g. compiling assets)
  class Application
    include ActiveSupport::Configurable

    # NOTE: Order matters. Plugins will be installed and initiallized in the
    # order they are listed.
    config_accessor :plugins do
      [
        ::BeltsCore,
        ::BeltsAssets,
        ::BeltsBGFX
      ]
    end

    def initialize
      config.plugins.each do |plugin_class|
        plugin_class.install
      end
    end

    def start
      @game = Game.new

      config.plugins.each do |plugin_class|
        plugin_class.init(@game)
      end

      @game.start

      while @game.running?
        @game.update
      end

      @game.quit
    end
  end
end
