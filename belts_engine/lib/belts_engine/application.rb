module BeltsEngine

  # The application ensures all libraries are loaded before starting the game.
  # It can also handle some pre-processing (e.g. compiling assets)
  class Application
    include BeltsSupport::Configuration

    config.plugins = [
      ::BeltsAssets
    ]

    def initialize
      config.plugins.each do |plugin_class|
        plugin_class.install
      end
    end

    def start
      @game = ::Game.new

      config.plugins.each do |plugin_class|
        plugin_class.init(@game)
      end

      config.plugins.each do |plugin_class|
        plugin_class.late_init(@game)
      end

      @game.start

      while @game.running?
        @game.update
      end

      @game.start
    end
  end
end
