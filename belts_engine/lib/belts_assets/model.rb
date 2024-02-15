module BeltsAssets
  class Model < Asset
    attr_accessor :root_node, :materials, :meshes, :textures

    def initialize
      @root_node = nil
      @materials = []
      @meshes = []
      @textures = []
    end

    def self.from_file(key, file)
      Importer.new(key, file).model
    end
  end
end
