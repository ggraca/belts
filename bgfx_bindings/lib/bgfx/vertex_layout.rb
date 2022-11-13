module BGFX
  class VertexLayout < FFI::Struct
    layout(
      hash: :uint,
      stride: :ushort,
      offset: [:ushort, Attrib[:Count]],
      attributes: [:ushort, Attrib[:Count]]
    )
  end
end
