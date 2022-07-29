Gem::Specification.new do |s|
  s.name = "cglm_bindings"
  s.version = "0.1.0"
  s.summary = "Ruby bindings for CGLM, a highly optimized math library for C"
  s.author = "Guilherme Graca"
  s.homepage = "https://github.com/ggraca/cglm-bindings"
  s.license = "MIT"

  s.files = Dir.glob("lib/**/*")

  s.add_dependency "ffi", "~> 1.15.5"
  s.add_dependency "zeitwerk", "~> 2.4.2"
end
