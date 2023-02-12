module BeltsAssets
  class Material < Asset
    attr_accessor :color
    attr_reader :surface

    def initialize
      @color = Vec3[0, 0, 0]
      @surface = Vec3[0, 0, 0]
    end

    def metallness=(value)
      @surface.x = value
    end

    def roughness=(value)
      @surface.y = value
    end
  end
end
