Entity = Struct.new(:id, :components)

class Scene
  attr_reader :game

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
    init_systems
    init_entities
  end

  def instantiate(components)
    @entities ||= []
    @max_id ||= 0

    @entities << Entity.new(@max_id += 1, components)

    @collections.each do |key, value|
      next if (key[:with] - components.keys).any?

      common_keys = key[:with] & components.keys
      value << components.slice(*common_keys)
    end
  end

  def collection(with: [], without: [])
    key = {with: with.sort, without: without.sort}
    raise "Collection not registered: #{key}" unless @collections.key?(key)

    @collections[key]
  end

  def register_collection(with: [], without: [])
    key = {with: with.sort, without: without.sort}

    @collections ||= {}
    @collections[key] = []
  end

  def update
    @systems.each(&:update)
  end

  private

  def init_systems
    @systems = []
    @collections = {}

    register_collection(with: [:transform, :camera_data])
    register_collection(with: [:transform, :render_data])

    klasses = Dir["app/systems/*.rb"].map do |file|
      File.basename(file, ".rb").camelize.constantize
    end

    klasses.each do |klass|
      klass.collection_keys.each do |key|
        register_collection(**key)
      end

      @systems << klass.new(self)
    end
  end

  def init_entities
    @@prefabs.each do |prefab|
      components = Marshal.load(Marshal.dump(prefab[:class_name].components)) # deep copy
      components[:transform].position = prefab[:position] if prefab[:position]
      components[:transform].rotation = prefab[:rotation] if prefab[:rotation]

      instantiate(components)
    end
  end
end
