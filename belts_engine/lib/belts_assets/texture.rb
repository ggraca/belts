module BeltsAssets
  class Texture < Asset
    attr_accessor :height, :width, :data

    def initialize(id)
      super(id)

      @height = nil
      @width = nil
      @data = nil
    end
  end
end
