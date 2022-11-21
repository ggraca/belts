module BeltsEngine
  class Application
    include BeltsSupport::Configuration

    config.plugins = [
      ::BeltsAssets
    ]

    def initialize
      @game = ::Game.new

      config.plugins.each do |plugin_class|
        plugin_class.install(@game)
      end

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
