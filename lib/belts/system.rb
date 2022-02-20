module Belts
  class System
    include System::CollectionMixin

    def initialize(scene)
      @scene = scene
      @game = scene.game
      @time = @game.time
    end
  end
end