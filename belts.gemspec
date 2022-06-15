Gem::Specification.new do |s|
  s.name = 'belts'
  s.version = '0.0.1'
  s.summary = "A game engine for Ruby."
  s.description = "A game engine for Ruby."
  s.author = "Guilherme Graca"
  s.homepage = 'https://github.com/ggraca/belts'
  s.license = 'MIT'

  s.files = Dir.glob("{lib,bin}/**/*")
  s.require_path = "lib"

  s.executable = 'belts'

  s.required_ruby_version = ">= 3.1.2"

  s.add_dependency 'belts_support', '~> 0.0.1'
  s.add_dependency 'belts_engine', '~> 0.0.1'
  s.add_dependency 'belts_opengl', '~> 0.0.1'
end
