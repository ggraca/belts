module BeltsAssets
  class Mesh
    attr_accessor :vertices, :indices

    def initialize
      @vertices = []
      @indices = []
    end
  end
end
