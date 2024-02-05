module BeltsSupport
  class Struct < FFI::Struct
    def self.ignore_reference? = true

    def as(equivalent)
      raise "The two structs must have the same size" if size != equivalent.size

      equivalent.new(pointer)
    end
  end
end
