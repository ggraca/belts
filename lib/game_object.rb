require_relative './renderer/game_object_helpers'

class GameObject
  # Transform = new Struct.new(:x, :y, :z)

  # def initialize
  #   @transform = Transform.new(0, 0, 0)
  # end

  self.instance_eval do
    extend Renderer::GameObjectHelpers
  end
end
