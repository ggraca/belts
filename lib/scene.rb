class Scene
  self.instance_eval do
    extend Module.new {
      def instantiate(class_name, options = {})
        @@prefabs ||= []
        @@prefabs << options.merge(class_name: class_name)
      end
    }
  end

  def initialize
    @max_id = 0
    @entities = []
    @collections = {}
    register_collection(:transform, :render_data)

    @@prefabs.each do |prefab|
      klass = prefab[:class_name]
      @max_id += 1
      @entities << @max_id

      @collections.each do |key, value|
        next if (key - klass.components.keys).any?

        value << {
          entity: @max_id,
          transform: klass.components[:transform],
          render_data: klass.components[:render_data]
        }
      end
    end
  end

  def entities
    @entities
  end

  def collection(*components)
    @collections[components]
  end

  def register_collection(*components)
    @collections[components] = []
  end
end
