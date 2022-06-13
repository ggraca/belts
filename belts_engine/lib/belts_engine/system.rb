module BeltsEngine
  class System
    include System::CollectionMixin

    def initialize(game)
      @game = game
      register_tool_shortcuts

      start
    end

    def start
    end

    private

    def register_tool_shortcuts
      @game.tools.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
