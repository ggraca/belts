module BeltsAssets
  class Texture < Asset
    class << self
      def default_texture
        new(:default).tap do |texture|
          texture.width = 1
          texture.height = 1
          texture.data = "0000"
        end
      end
    end

    attr_accessor :height, :width, :data

    def initialize(id)
      super(id)

      @height = nil
      @width = nil
      @data = nil
    end
  end
end
