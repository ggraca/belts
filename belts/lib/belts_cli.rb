require "thor"
require "belts"

class BeltsCli < Thor
  default_task :start

  desc "start", "Starts the game"
  subcommand "start", Belts::Initializer

  desc "new NAME", "Generate a new project in the current directory with the given NAME"
  subcommand "new", Belts::Generator
end
