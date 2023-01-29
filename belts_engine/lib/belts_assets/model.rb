module BeltsAssets
  class Model < Asset
    attr_accessor :root_node, :materials, :meshes

    def initialize
      @root_node = nil
      @materials = []
      @meshes = []
    end

    def self.from_file(key, file)
      Importer.new(key, file).model
    end
  end
end
