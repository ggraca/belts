require 'zeitwerk'
require 'opengl'
require 'glfw'
require 'matrix'
require 'active_support/inflector'

require_relative './belts_components/vec3'
require_relative './belts_components/mat4'
require_relative './belts_components/transform'
require_relative './belts_components/camera_data'
require_relative './belts_components/light_data'
require_relative './belts_components/render_data'

loader = Zeitwerk::Loader.for_gem
loader.setup

module Belts
  def self.init
    init_zeitwerk_loader

    @game = Game.new

    while true
      @game.update
    end
  end

  def self.root
    File.dirname __dir__
  end

  private

  def self.init_zeitwerk_loader
    @zeitwerk_loader = Zeitwerk::Loader.new

    Dir.glob('app/*').each do |dir|
      @zeitwerk_loader.push_dir dir
    end

    @zeitwerk_loader.enable_reloading
    @zeitwerk_loader.setup
  end
end

require_relative './belts_prefabs/camera_2d'
require_relative './belts_prefabs/camera_3d'
require_relative './belts_prefabs/light'
