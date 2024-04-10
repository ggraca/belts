module BeltsSupport
  class Struct < FFI::Struct
    class << self
      def ignore_reference? = true

      def []
        new
      end
    end

    def as(equivalent)
      raise "The two structs must have the same size" if size != equivalent.size

      equivalent.new(pointer)
    end
  end
end
