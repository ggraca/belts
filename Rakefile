GEMS = ["belts", "belts_engine", "belts_support", "belts_opengl"]
VERSION = File.read(File.expand_path("./.belts-version", __dir__)).strip

desc "Build gems"
task :build do
  GEMS.each do |name|
    system "gem build -C #{name}"
  end
end
