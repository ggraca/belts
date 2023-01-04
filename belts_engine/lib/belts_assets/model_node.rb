module BeltsAssets
  class ModelNode
    attr_accessor :parent, :children, :name, :mesh_ids, :transformation

    def initialize
      @parent = nil
      @children = []
      @mesh_ids = []
      @transformation = Mat4.identity
    end
  end
end
