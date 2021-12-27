module ComponentMixin
  class << self
    def included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def components
      @components ||= {}
    end

    def set_component(name, data)
      @components ||= {}
      @components[name] = data
    end
  end
end

module RendererMixin
  class << self
    def included(base)
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def renderer(type, options = {})
      set_component(:render_data, RenderData.new(type, options[:color], options[:flip]))
    end
  end
end

class GameObject
  include ComponentMixin
  include RendererMixin
end
