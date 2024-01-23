module BeltsSupport
  class Component < FFI::Struct
    def self.ignore_reference? = true

    def set!(equivalent)
      raise "The two structs must have the same size" if size != equivalent.size

      pointer.put_bytes(0, equivalent.pointer.get_bytes(0, size))
    end
  end
end
