module BeltsAssets
  class ModelNode
    attr_accessor :parent, :children, :name

    def initialize
      @parent = nil
      @children = []
      @mesh_ids = []
      @transform = Mat4.identity
    end
  end
end
