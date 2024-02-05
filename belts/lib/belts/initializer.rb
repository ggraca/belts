module Belts
  class Initializer < Thor
    default_task :start

    desc "start", "Starts the game"
    def start
      app_loader = Zeitwerk::Loader.new
      app_loader.push_dir("config")
      Dir.glob("app/*").each do |dir|
        app_loader.push_dir dir
      end
      app_loader.setup
      app_loader.eager_load # TODO: Remove this line?

      app = Application.new
      app.start
    end
  end
end
