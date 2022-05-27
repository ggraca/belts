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

    def create_configs
      template("templates/config/application.rb.tt", "#{name}/config/application.rb")
      template("templates/config/game.rb.tt", "#{name}/config/game.rb")
    end

    def create_app
      template("templates/app/components/spinner.rb.tt", "#{name}/app/components/spinner.rb")
      template("templates/app/prefabs/spinning_cube.rb.tt", "#{name}/app/prefabs/spinning_cube.rb")
      template("templates/app/prefabs/camera_3d.rb.tt", "#{name}/app/prefabs/camera_3d.rb")
      template("templates/app/scenes/main_scene.rb.tt", "#{name}/app/scenes/main_scene.rb")
      template("templates/app/systems/spinner_system.rb.tt", "#{name}/app/systems/spinner_system.rb")
    end
  end
end
