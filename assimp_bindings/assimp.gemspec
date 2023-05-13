Gem::Specification.new do |s|
  s.name = "assimp_bindings"
  s.version = "0.1.0"
  s.summary = "Ruby bindings for Assimp, a 3D asset loading library"
  s.author = "Guilherme Graca"
  s.homepage = "https://github.com/ggraca/assimp-bindings"
  s.license = "MIT"

  s.files = Dir.glob("lib/**/*")

  s.add_dependency "ffi", "~> 1.15.5"
  s.add_dependency "zeitwerk", "~> 2.4.2"
end
