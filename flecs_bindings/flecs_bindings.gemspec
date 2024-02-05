Gem::Specification.new do |s|
  s.name = "flecs_bindings"
  s.version = "0.1.0"
  s.summary = "Ruby bindings for Flecs, a fast and lightweight Entity Component System"
  s.author = "Guilherme Graca"
  s.homepage = "https://github.com/ggraca/flecs-bindings"
  s.license = "MIT"

  s.files = Dir.glob("lib/**/*")

  s.add_dependency "ffi", "~> 1.15.5"
  s.add_dependency "zeitwerk", "~> 2.4.2"

  s.add_development_dependency "rspec", "~> 3.11"
end
