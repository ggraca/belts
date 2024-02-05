module BeltsEngine
  class System
    include System::QueryMixin
    include System::PhaseMixin

    def initialize(game)
      @game = game
      @started = false
      register_tool_shortcuts
    end

    # Runs once before the first update
    def start; end

    # Runs once per frame
    def update; end

    def progress(ctx = nil)
      return update if @started

      start
      @started = true
    rescue => e
      # TODO: handle this in a useful way
      pp e
    end

    private

    def register_tool_shortcuts
      @game.tools.each do |key, value|
        instance_variable_set(:"@#{key}", value)
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
