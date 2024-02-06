version = File.read(File.expand_path("../.belts-version", __dir__)).strip

Gem::Specification.new do |s|
  s.name = "belts"
  s.version = version
  s.summary = "A data-oriented game engine for Ruby."
  s.author = "Guilherme Graca"
  s.homepage = "https://github.com/ggraca/belts"
  s.license = "MIT"

  s.files = Dir.glob("{lib,bin}/**/*", File::FNM_DOTMATCH)
  s.executable = "belts"

  s.required_ruby_version = ">= 3.1.2"
  s.add_dependency "belts_engine", version
  s.add_dependency "thor", "~> 1.2.1"
  s.add_development_dependency "standard", "~> 1.12"
  s.add_development_dependency "rspec", "~> 3.12"
  s.add_development_dependency "rubocop-rspec", "~> 2.11"
end
