VERSION = File.read(File.expand_path("../.belts-version", __dir__)).strip

Gem::Specification.new do |s|
  s.name = "belts_opengl"
  s.version = VERSION
  s.summary = "OpenGL graphics plugin for the Belts game engine"
  s.author = "Guilherme Graca"
  s.homepage = "https://github.com/ggraca/belts"
  s.license = "MIT"

  s.files = Dir.glob("lib/**/*")

  s.required_ruby_version = ">= 3.1.2"
  s.add_dependency "belts_engine", VERSION
  s.add_dependency "opengl-bindings2", "~> 2.0.0"
end
