module BeltsAssets
  class ModelNode < Asset
    attr_accessor :parent, :children, :mesh_ids, :transformation

    def initialize
      @parent = nil
      @children = []
      @mesh_ids = []
      @transformation = Mat4.identity
    end
  end
end
