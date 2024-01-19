module BeltsEngine
  class System
    include System::QueryMixin

    def initialize(game)
      @game = game
      register_tool_shortcuts
    end

    def start; end
    def update; end

    private

    def register_tool_shortcuts
      @game.tools.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
