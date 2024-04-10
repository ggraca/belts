module BeltsAssets
  class Asset
    attr_accessor :id, :name

    def initialize(id)
      raise "Invalid id: #{id}" if id.nil? || id.empty?

      @id = id
    end
  end
end
