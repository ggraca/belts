module BeltsAssets
  class Mesh
    attr_accessor :vertices, :indices, :id

    def initialize
      @vertices = []
      @indices = []
    end
  end
end
