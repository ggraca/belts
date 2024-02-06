module BeltsAssets
  class Config
    module ModelMixin
      class << self
        def included(base)
          base.extend ClassMethods
        end
      end

      module ClassMethods
        def model(key, file)
          @@models ||= {}
          @@models[key] = {file: Dir["assets/#{file}"].first}
        end

        def models
          @@models ||= {}
        end
      end
    end
  end
end
