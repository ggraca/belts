module Belts
  class Engine < Thor::Group
    include Thor::Actions

    argument :name
    class_option :ruby_version, default: RUBY_VERSION

    def self.source_root
      File.dirname(__FILE__)
    end

    def create_gemfile
      template("templates/.ruby-version.tt", "#{name}/.ruby-version")
      template("templates/Gemfile.tt", "#{name}/Gemfile")
    end

    def create_config
      config_files = [
        "application.rb",
        "game.rb"
      ]

      config_files.each do |file|
        template("templates/config/#{file}.tt", "#{name}/config/#{file}")
      end
    end

    def create_app
      app_files = [
        "components/spinner.rb",
        "prefabs/spinning_cube.rb",
        "prefabs/camera_3d.rb",
        "scenes/main_scene.rb",
        "systems/spinner_system.rb"
      ]

      app_files.each do |file|
        template("templates/app/#{file}.tt", "#{name}/app/#{file}")
      end
    end
  end
end
