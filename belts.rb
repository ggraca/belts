require 'zeitwerk'
require 'opengl'
require 'glfw'
require 'glu'

class Belts
  def self.init
    belts = Belts.new

    while true
      belts.update
    end
  end

  def initialize
    init_zeitwerk_loader
    init_renderer
    init_asset_manager

    @renderer.set_asset_manager(@asset_manager)

    @scene = MainScene.new
    @renderer.set_current_scene(@scene)

    # audio = Audio.new
    # level = load_level
    # game = Game.new(renderer, audio, level)
  end

  def update
    @zeitwerk_loader.reload
    @scene.update
    @renderer.update

    # renderer.perform
    # audio.perform
    # physics.perform
  end

  private

  def init_renderer
    @renderer = Renderer.new
  end

  def init_asset_manager
    @asset_manager = AssetManager.new
  end

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

Belts.init
