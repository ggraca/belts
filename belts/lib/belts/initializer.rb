module Belts
  class Initializer < Thor
    default_task :start

    desc "start", "Starts the game"
    def start
      Dir.glob("config/*").each do |dir|
        load dir
      end

      app = BeltsEngine::Application.new

      app_loader = Zeitwerk::Loader.new
      Dir.glob("app/*").each do |dir|
        app_loader.push_dir dir
      end
      app_loader.setup
      app_loader.eager_load # TODO: Remove this line?

      app.start
    end
  end
end
