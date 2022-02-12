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

    def component(name, val)
      set_component(name, val)
    end

    private

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
    def renderer(type, **options)
      set_component(:render_data, RenderData.new(type, options[:color]))
    end
  end
end

class Prefab
  include ComponentMixin
  include RendererMixin

  def self.inherited(subclass)
    super
    subclass.component(:transform, Transform.new)
  end
end
