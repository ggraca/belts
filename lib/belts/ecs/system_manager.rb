module Belts::Ecs
  class SystemManager
    def initialize(game)
      @game = game
      @systems = []

      register_app_systems
    end

    def update
      @systems.each(&:update)
    end

    def register_system(klass)
      @systems << klass.new(@game) # TODO: Avoid duplicates

      klass.collection_keys.each do |key|
        @game.entities.register_collection(**key)
      end
    end

    private

    def register_app_systems
      klasses = Dir["app/systems/*.rb"].map do |file|
        File.basename(file, ".rb").camelize.constantize
      end

      klasses.each do |klass|
        register_system(klass)
      end
    end
  end
end
