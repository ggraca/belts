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
    @renderers = []

    @@prefabs.each do |prefab|
      @max_id += 1
      @entities << @max_id
      @renderers << prefab[:class_name]::components[:render_data]
    end
  end

  def entities
    @entities
  end

  def renderers
    @renderers
  end
end
