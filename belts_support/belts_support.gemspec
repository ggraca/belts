VERSION = File.read(File.expand_path("../.belts-version", __dir__)).strip

Gem::Specification.new do |s|
  s.name = "belts_support"
  s.version = VERSION
  s.summary = "Common tools for the Belts game engine"
  s.author = "Guilherme Graca"
  s.homepage = "https://github.com/ggraca/belts"
  s.license = "MIT"

  s.files = Dir.glob("lib/**/*")

  s.required_ruby_version = ">= 3.1.2"
  s.add_dependency "activesupport", "~> 7.0.0"
  s.add_dependency "matrix", "~> 0.4.2"
  s.add_dependency "zeitwerk", "~> 2.4.2"
end
