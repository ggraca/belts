module BeltsEngine
  class System
    include System::QueryMixin

    def initialize(game)
      @game = game
      register_tool_shortcuts
    end

    # Runs once before the first update
    def start; end

    # Runs once per frame
    def update; end

    private

    def register_tool_shortcuts
      @game.tools.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def debug(db = true)
      return yield unless db
      RubyProf.start

      yield
      result = RubyProf.stop
      printer = RubyProf::FlatPrinter.new(result)
      printer.print(STDOUT)
      exit
    end
  end
end
