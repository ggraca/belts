module BeltsAssets
  class Model < Asset
    attr_accessor :root_node

    def initialize(id)
      super(id)

      @root_node = nil
    end
  end
end
