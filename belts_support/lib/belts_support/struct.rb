module BeltsSupport
  # This allows ffi structs to inherit the layout of their parent class.
  class Struct < FFI::Struct
    class << self
      def inherited(subclass)
        super

        if @layout_args.present?
          subclass.layout(*@layout_args)
        end
      end

      def layout(*args)
        @layout_args = args
        super
      end
    end

    def set!(equivalent)
      pointer.put_bytes(0, equivalent.pointer.get_bytes(0, size))
    end
  end
end
