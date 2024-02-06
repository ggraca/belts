module BeltsSupport
  module Extension
    class << self
      def extended(base)
        base.include ActiveSupport::Configurable
      end
    end

    # Handle application installation (loading libraries, mixins, etc.)
    def install
    end

    # Handle game initialization (registering tools, loading assets, etc.)
    def init(game)
    end
  end
end
