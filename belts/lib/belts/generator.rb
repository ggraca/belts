module Belts
  class Generator < Thor
    default_task :new

    desc "new NAME", "Generate a new project in the current directory with the given NAME"
    def new(name)
      invoke :engine, name
    end

    register(Belts::Engine, "engine", "engine", "Badjoras")
  end
end
