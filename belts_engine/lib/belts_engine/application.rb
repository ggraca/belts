module BeltsEngine
  class Application
    include BeltsSupport::Configuration

    config.plugins = []

    def initialize
      @game = ::Game.new

      config.plugins.each do |plugin_class|
        @game.use plugin_class
      end

      @game.start

      while true
        @game.update
      end
    end
  end
end
