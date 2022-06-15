Gem::Specification.new do |s|
  s.name = 'belts_opengl'
  s.version = '0.0.1'
  s.summary = "OpenGL graphics plugin for the Betls game engine"
  s.description = "OpenGL graphics plugin for the Betls game engine"
  s.author = "Guilherme Graca"
  s.homepage = 'https://github.com/ggraca/belts'
  s.license = 'MIT'

  s.files = Dir.glob("lib/**/*")
  s.require_path = "lib"

  s.required_ruby_version = ">= 3.1.2"

  s.add_dependency 'opengl-bindings2', '~> 2.0.0'
  s.add_dependency 'belts_engine', '~> 0.0.1'
  s.add_dependency 'belts_support', '~> 0.0.1'
end
