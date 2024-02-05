module BeltsEngine
  class System
    module PhaseMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def pipeline_phase
          @pipeline_phase ||= nil
        end

        def phase(name)
          @pipeline_phase = name
        end
      end
    end
  end
end
