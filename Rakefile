GEMS = ["belts_support", "belts_engine", "belts_bgfx", "belts"]
VERSION = File.read(File.expand_path("./.belts-version", __dir__)).strip

desc "Build gems"
task :build do
  GEMS.each do |name|
    system "gem build -C #{name}"
  end
end

desc "Install gems"
task :install do
  GEMS.each do |name|
    system "gem install #{name}/#{name}-#{VERSION}.gem"
  end
end

desc "Uninstall gems"
task :uninstall do
  GEMS.each do |name|
    system "gem uninstall #{name}"
  end
end

desc "Publish gems"
task :publish do
  GEMS.each do |name|
    system "gem push #{name}/#{name}-#{VERSION}.gem"
  end
end

desc "Cleanup gem files"
task :cleanup do
  GEMS.each do |name|
    system "rm #{name}/#{name}-#{VERSION}.gem"
  end
end
