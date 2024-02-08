require "flecs"

RSpec.configure do |config|
  Flecs.load_lib(File.expand_path("../vendor/libflecs.so", __dir__))
end
