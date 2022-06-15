Gem::Specification.new do |s|
  s.name = 'belts_engine'
  s.version = '0.0.1'
  s.summary = "The core functionality of the Belts game engine"
  s.description = "ECS management, input, time, etc."
  s.author = "Guilherme Graca"
  s.homepage = 'https://github.com/ggraca/belts'
  s.license = 'MIT'

  s.files = Dir.glob("lib/**/*")
  s.require_path = "lib"

  s.required_ruby_version = ">= 3.1.2"
end
