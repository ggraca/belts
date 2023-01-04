module BeltsAssets
  class Model
    attr_accessor :id, :root_node, :materials, :meshes

    def initialize
    end

    def self.from_file(key, file)
      Importer.new(key, file).model
    end
  end
end
