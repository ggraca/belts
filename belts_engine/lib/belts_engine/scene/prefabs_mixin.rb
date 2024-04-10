module BeltsEngine
  class Scene
    module PrefabsMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def prefabs
          @prefabs ||= []
        end

        def prefab(name, **options)
          prefabs << options.merge(name: name)
        end
      end
    end
  end
end
