require 'zeitwerk'
require 'opengl'
require 'glfw'
require 'matrix'
require 'active_support/inflector'

require_relative './belts_components/vec3'
require_relative './belts_components/mat4'
require_relative './belts_components/transform'

loader = Zeitwerk::Loader.for_gem
loader.setup

# TODO: Add abstraction for time and input. Then we can put this in a more specific module
include OpenGL
include GLFW

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
