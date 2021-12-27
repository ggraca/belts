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
    @system = SpinnerSystem.new(self)
    @max_id = 0
    @entities = []
    @collections = {}
    register_collection(:transform, :render_data)
    register_collection(:transform, :spinner)

    @@prefabs.each do |prefab|
      klass = prefab[:class_name]
      @max_id += 1
      @entities << @max_id

      @collections.each do |key, value|
        next if (key - klass.components.keys).any?

        data = { entity: @max_id }
        common_keys = key & klass.components.keys
        common_keys.each do |k|
          data[k] = klass.components[k]
        end


        value << data
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

  def update
    @system.update
  end
end
