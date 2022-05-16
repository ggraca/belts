module Belts
  class Initializer < Thor::Group
    desc "Starts the game"

    def start
      app_loader = Zeitwerk::Loader.new
      app_loader.push_dir('config')
      Dir.glob('app/*').each do |dir|
        app_loader.push_dir dir
      end
      app_loader.setup

      Application.new
    end
  end
end
