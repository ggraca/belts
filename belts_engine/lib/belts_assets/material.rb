module BeltsAssets
  class Material < Asset
    attr_accessor :color, :texture_ids
    attr_reader :surface

    def initialize(id)
      super(id)

      @color = Vec4[0, 0, 0, 0]
      @surface = Vec4[0, 0, 0, 0]
      @texture_ids = {}
    end

    def roughness=(value)
      @surface.x = value
    end

    def metallness=(value)
      @surface.y = value
    end
  end
end
