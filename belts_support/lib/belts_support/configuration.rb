module BeltsSupport
  module Configuration
    class << self
      def included(base)
        base.extend ClassMethods
        base.include InstanceMethods
      end
    end

    module ClassMethods
      def config
        @config ||= ConfigurationObject.new
      end
    end

    module InstanceMethods
      def config
        self.class.config
      end
    end

    class ConfigurationObject
      def initialize
        @@options ||= {}
      end

      def respond_to?(name, include_private = false)
        super || @@options.key?(name.to_sym)
      end

      private

      def method_missing(name, *args, &blk)
        if name.end_with?("=")
          @@options[:"#{name[0..-2]}"] = args.first
        elsif @@options.key?(name)
          @@options[name]
        else
          super
        end
      end
    end
  end
end
