module BeltsEngine
  class System
    include System::CollectionMixin

    def initialize(game)
      @game = game
      @entities = game.entities
      @time = game.time
      @input = game.input

      start
    end

    def start
    end
  end
end
