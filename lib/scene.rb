class Scene
  self.instance_eval do
    extend Module.new {
      def prefab(class_name, **options)
        @@prefabs ||= []
        @@prefabs << options.merge(class_name: class_name)
      end
    }
  end

  def initialize(game)
    @game = game
    @systems = autoload_systems
    @max_id = 0
    @entities = []
    @collections = {}
    register_collection(:transform, :camera_data)
    register_collection(:transform, :light_data)
    register_collection(:transform, :render_data)
    register_collection(:transform, :spinner)

    @@prefabs.each do |prefab|
      instantiate(prefab[:class_name], prefab[:position], prefab[:rotation])
    end
  end

  def instantiate(klass, position, rotation)
    @max_id += 1
    @entities << @max_id
    components = Marshal.load(Marshal.dump(klass.components))
    components[:transform].position = position if position
    components[:transform].rotation = rotation if rotation

    @collections.each do |key, value|
      next if (key - components.keys).any?

      common_keys = key & components.keys
      value << components.slice(*common_keys).merge(entity: @max_id)
    end
  end

  def entities
    @entities
  end

  def collection(*components)
    raise "Collection not registered: #{components}" unless @collections.key?(components)

    @collections[components]
  end

  def register_collection(*components)
    @collections[components] = []
  end

  def update
    @systems.each(&:update)
  end

  private

  def autoload_systems
    # TODO: grab systems from /app/systems
    [SpinnerSystem.new(self), CameraControllerSystem.new(self)]
  end
end
