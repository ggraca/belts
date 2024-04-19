module Belts
  class Engine < Thor::Group
    include Thor::Actions

    argument :name
    class_option :ruby_version, default: RUBY_VERSION

    def self.source_root
      File.dirname(__FILE__)
    end

    def main
      directory "templates", name
    end
  end
end
