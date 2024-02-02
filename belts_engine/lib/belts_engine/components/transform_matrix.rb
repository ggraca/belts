class TransformMatrix < BeltsSupport::Component
  include Mat4Behaviour

  def set_transform!(position, rotation, scale)
    ptr = FFI::MemoryPointer.new(:pointer, 3)
    ptr.write_array_of_pointer([Mat4.translation(position), Mat4.rotation(rotation), Mat4.scale(scale)])

    GLM.glmc_mat4_mulN(ptr, 3, self)
  end
end
