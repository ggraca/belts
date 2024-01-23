module BeltsSupport
  class Struct < FFI::Struct
    def self.ignore_reference? = true
  end
end
