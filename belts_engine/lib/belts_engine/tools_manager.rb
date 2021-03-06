module BeltsEngine
  module ToolsManager
    def tools
      @_tools ||= {}
    end

    def register_tool(name, obj)
      raise "Tool #{name} already in use" if tools.key?(name)

      tools[name] = obj
    end

    def respond_to?(name, include_private = false)
      super || tools.key?(name.to_sym)
    end

    private

    def method_missing(name, *args, &blk)
      raise "Tool #{name} not registered" unless tools.key?(name)

      tools[name]
    end

    def respond_to_missing?(name, *args)
      tools[name] || super
    end
  end
end
