module Belts
  class Generator < Thor::Group
    argument :name, type: :string, desc: "The name of the new project"
    desc "Generate a new project in the current directory with the given NAME"

    def new
      pp name
    end
  end
end
