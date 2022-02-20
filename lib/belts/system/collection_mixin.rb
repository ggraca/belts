module Belts
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

        def collection(name, with: [], without: [])
          key = {with: with, without: without}
          register_collection_key(key)

          define_method(name) do
            @scene.collection(**key)
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
