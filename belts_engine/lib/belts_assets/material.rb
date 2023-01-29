module BeltsAssets
  class Material < Asset
    attr_accessor :color

    def initialize
      @color = Vec3[0, 0, 0]
    end
  end
end
