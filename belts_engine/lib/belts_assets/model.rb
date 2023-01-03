module BeltsAssets
  class Model
    attr_accessor :id, :root_node, :materials, :meshes, :mesh_ids

    def initialize
      @mesh_ids = []
    end

    def self.from_file(key, file)
      Importer.new(key, file).model
    end
  end
end
