module BeltsEngine
  class System
    module QueryMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def queries
          @queries ||= {}
        end

        def query(name, **filters)
          raise "Query #{name} already defined" if queries[name].present?

          queries[name] = filters
          define_method(name) do
            @game.ecs.query(filters)
          end
        end
      end
    end
  end
end
