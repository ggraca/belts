module BeltsAssets
  class ModelNode

    # belongs_to :model_node, optional: true
    # has_many :model_nodes
    # has_many :meshes

    def initialize
      @parent = nil
      @children = []
      @mesh_ids = []
      @transform = Mat4.identity
    end
  end
end
