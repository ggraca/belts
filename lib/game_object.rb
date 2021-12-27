class GameObject
  # Transform = new Struct.new(:x, :y, :z)

  # def initialize
  #   @transform = Transform.new(0, 0, 0)
  # end

  self.instance_eval do
    @@components ||= {}
    @@components[:transform] = Float3.new(0, 0, 0)

    def renderer(type, options = {})
      @@components[:render_data] = RenderData.new(type, options[:color], options[:flip])
    end
  end

  def self.components
    @@components
  end
end
