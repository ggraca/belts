Gem::Specification.new do |s|
  s.name = 'belts'
  s.version = '0.1.0'
  s.summary = "A data-oriented game engine for Ruby."
  s.description = "A data-oriented game engine for Ruby."
  s.author = "Guilherme Graca"
  s.homepage = 'https://github.com/ggraca/belts'
  s.license = 'MIT'

  s.files = Dir.glob("{lib,bin}/**/*")
  s.executable = 'belts'

  s.required_ruby_version = ">= 3.1.2"
  s.add_dependency 'belts_engine', '~> 0.1.0'
  s.add_dependency 'belts_opengl', '~> 0.1.0'
  s.add_dependency 'thor', '~> 1.2.1'
end
