module BGFX
  extend FFI::Library

  Fatal = enum [
    :DebugCheck,
    :InvalidShader,
    :UnableToInitialize,
    :UnableToCreateTexture,
    :DeviceLost,

    :Count
  ]

  RendererType = enum [
    :Noop,
    :Agc,
    :Direct3D9,
    :Direct3D11,
    :Direct3D12,
    :Gnm,
    :Metal,
    :Nvn,
    :OpenGLES,
    :OpenGL,
    :Vulkan,
    :WebGPU,

    :Count
  ]

  Access = enum [
    :Read,
    :Write,
    :ReadWrite,

    :Count
  ]

  Attrib = enum [
    :Position,
    :Normal,
    :Tangent,
    :Bitangent,
    :Color0,
    :Color1,
    :Color2,
    :Color3,
    :Indices,
    :Weight,
    :TexCoord0,
    :TexCoord1,
    :TexCoord2,
    :TexCoord3,
    :TexCoord4,
    :TexCoord5,
    :TexCoord6,
    :TexCoord7,

    :Count
  ]

  AttribType = enum [
    :Uint8,
    :Uint10,
    :Int16,
    :Half,
    :Float,

    :Count
  ]

  TextureFormat = enum [
    :BC1,
    :BC2,
    :BC3,
    :BC4,
    :BC5,
    :BC6H,
    :BC7,
    :ETC1,
    :ETC2,
    :ETC2A,
    :ETC2A1,
    :PTC12,
    :PTC14,
    :PTC12A,
    :PTC14A,
    :PTC22,
    :PTC24,
    :ATC,
    :ATCE,
    :ATCI,
    :ASTC4x4,
    :ASTC5x4,
    :ASTC5x5,
    :ASTC6x5,
    :ASTC6x6,
    :ASTC8x5,
    :ASTC8x6,
    :ASTC8x8,
    :ASTC10x5,
    :ASTC10x6,
    :ASTC10x8,
    :ASTC10x10,
    :ASTC12x10,
    :ASTC12x12,

    :Unknown,

    :R1,
    :A8,
    :R8,
    :R8I,
    :R8U,
    :R8S,
    :R16,
    :R16I,
    :R16U,
    :R16F,
    :R16S,
    :R32I,
    :R32U,
    :R32F,
    :RG8,
    :RG8I,
    :RG8U,
    :RG8S,
    :RG16,
    :RG16I,
    :RG16U,
    :RG16F,
    :RG16S,
    :RG32I,
    :RG32U,
    :RG32F,
    :RGB8,
    :RGB8I,
    :RGB8U,
    :RGB8S,
    :RGB9E5,
    :BGRA8,
    :RGBA8,
    :RGBA8I,
    :RGBA8U,
    :RGBA8S,
    :RGBA16,
    :RGBA16I,
    :RGBA16U,
    :RGBA16F,
    :RGBA16S,
    :RGBA32I,
    :RGBA32U,
    :RGBA32F,
    :B5G6R5,
    :R5G6B5,
    :BGRA4,
    :RGBA4,
    :BGR5A1,
    :RGB5A1,
    :RGB10A2,
    :RG11B10F,
    :UnknownDepth,
    :D16,
    :D24,
    :D24S8,
    :D32,
    :D16F,
    :D24F,
    :D32F,
    :D0S8,

    :Count
  ]

  UniformType = enum [
    :Sampler,
    :End,

    :Vec4,
    :Mat3,
    :Mat4,

    :Count
  ]

  BackbufferRatio = enum [
    :Equal,
    :Half,
    :Quarter,
    :Eighth,
    :Sixteenth,
    :Double,

    :Count
  ]

  OcclusionQueryResult = enum [
    :Invisible,
    :Visible,
    :NoResult,

    :Count
  ]

  Topology = enum [
    :TriList,
    :TriStrip,
    :LineList,
    :LineStrip,
    :PointList,

    :Count
  ]

  TopologyConvert = enum [
    :TriListFlipWinding,
    :TriStripFlipWinding,
    :TriListToLineList,
    :TriStripToTriList,
    :LineStripToLineList,

    :Count
  ]

  TopologySort = enum [
    :DirectionFrontToBackMin,
    :DirectionFrontToBackAvg,
    :DirectionFrontToBackMax,
    :DirectionBackToFrontMin,
    :DirectionBackToFrontAvg,
    :DirectionBackToFrontMax,
    :DistanceFrontToBackMin,
    :DistanceFrontToBackAvg,
    :DistanceFrontToBackMax,
    :DistanceBackToFrontMin,
    :DistanceBackToFrontAvg,
    :DistanceBackToFrontMax,

    :Count
  ]

  ViewMode = enum [
    :Default,
    :Sequential,
    :DepthAscending,
    :DepthDescending,

    :Count
  ]

  RenderFrame = enum [
    :NoContext,
    :Render,
    :Timeout,
    :Exiting,

    :Count
  ]
end
