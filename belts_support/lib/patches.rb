# NOTE: Monkey patch to allow structs to be passed by reference without checking their class.
# This improves performance significantly by allowing similar structs to be referenced without
# the need instantiate a new class to cast them.
# e.g. A Flecs Vec3 component can be passed to a CGLM Vec3 function.
module FFI
  class Struct
    def self.ignore_reference? = false
  end

  class StructByReference
    def to_native(value, ctx)
      # TODO: This check still consumes 1/3 of the function call time
      return value.pointer if value.class.respond_to?(:ignore_reference?) && value.class.ignore_reference?
      return Pointer::NULL if value.nil?

      unless @struct_class === value
        raise TypeError, "wrong argument type #{value.class} (expected #{@struct_class})"
      end

      value.pointer
    end
  end
end
