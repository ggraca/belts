module Belts
  class System
    include System::CollectionMixin

    def initialize(game)
      @game = game
      @entities = game.entities
      @time = @game.time
      @input = @game.input
    end
  end
end
