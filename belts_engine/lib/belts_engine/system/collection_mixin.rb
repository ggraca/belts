module BeltsEngine
  class System
    module CollectionMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def collection_keys
          @collection_keys ||= []
        end

        def collection(name, **filters)
          key = Ecs::Collection.new(**filters).key
          register_collection_key(key)

          define_method(name) do
            @collections.get(key)
          end
        end

        private

        def register_collection_key(key)
          @collection_keys ||= []
          @collection_keys << key
        end
      end
    end
  end
end
