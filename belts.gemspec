Gem::Specification.new do |s|
  s.name = 'belts'
  s.version = '0.0.0'
  s.summary = "A game engine for Ruby."
  s.description = "A game engine for Ruby."
  s.authors = ["Guilherme Graca"]
  s.homepage = 'https://github.com/ggraca/belts'
  s.license = 'MIT'

  s.files = Dir.glob("{lib,bin}/**/*")
  s.require_path = "lib"

  s.executable = 'belts'

  s.required_ruby_version = ">= 3.0.1"

  s.add_dependency 'activesupport', '~> 7.0.0'
  s.add_dependency 'opengl-bindings', '~> 1.6.11'
  s.add_dependency 'zeitwerk', '~> 2.4.2'
end
