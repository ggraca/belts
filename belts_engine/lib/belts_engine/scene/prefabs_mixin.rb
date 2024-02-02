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

        def prefab(class_name, **options)
          prefabs << options.merge(class_name: class_name)
        end
      end
    end
  end
end
