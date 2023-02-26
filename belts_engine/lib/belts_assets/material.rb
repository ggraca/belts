module BeltsAssets
  class Material < Asset
    attr_accessor :color
    attr_reader :surface

    def initialize
      @color = Vec4[0, 0, 0, 0]
      @surface = Vec4[0, 0, 0, 0]
    end

    def roughness=(value)
      @surface.x = value
    end

    def metallness=(value)
      @surface.y = value
    end
  end
end
