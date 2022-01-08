require 'zeitwerk'
require 'opengl'
require 'glfw'
require 'glu'

class Belts
  def initialize
    init_zeitwerk_loader

    @game = Game.new

    while true
      @zeitwerk_loader.reload
      @game.update
    end
  end

  private

  def init_zeitwerk_loader
    @zeitwerk_loader = Zeitwerk::Loader.new

    Dir.glob('lib').each do |dir|
      @zeitwerk_loader.push_dir dir
    end

    Dir.glob('app/*').each do |dir|
      @zeitwerk_loader.push_dir dir
    end

    @zeitwerk_loader.enable_reloading
    @zeitwerk_loader.setup
  end
end

Belts.new
