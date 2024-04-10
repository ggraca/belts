module Assimp
  extend FFI::Library

  Return = enum [:Success]

  TextureType = enum [
    :NONE,
    :DIFFUSE,
    :SPECULAR,
    :AMBIENT,
    :EMISSIVE,
    :HEIGHT,
    :NORMALS,
    :SHININESS,
    :OPACITY,
    :DISPLACEMENT,
    :LIGHTMAP,
    :REFLECTION,

    :BASE_COLOR,
    :NORMAL_CAMERA,
    :EMISSION_COLOR,
    :METALNESS,
    :DIFFUSE_ROUGHNESS,
    :AMBIENT_OCCLUSION,

    :SHEEN,
    :CLEARCOAT,
    :TRANSMISSION,
    :UNKNOWN
  ]

  module Component
    NORMALS = 0x2
    TANGENTS_AND_BITANGENTS = 0x4
    COLORS = 0x8
    TEXTURE_COORDS = 0x10
    BONE_WEIGHTS = 0x20
    ANIMATIONS = 0x40
    TEXTURES = 0x80
    LIGHTS = 0x100
    CAMERAS = 0x200
    MESHES = 0x400
    MATERIALS = 0x800
  end

  module Matkey
    NAME = "?mat.name"
    TWOSIDED = "$mat.twosided"
    SHADING_MODEL = "$mat.shadingm"
    ENABLE_WIREFRAME = "$mat.wireframe"
    BLEND_FUNC = "$mat.blend"
    OPACITY = "$mat.opacity"
    BUMPSCALING = "$mat.bumpscaling"
    SHININESS = "$mat.shininess"
    REFLECTIVITY = "$mat.reflectivity"
    SHININESS_STRENGTH = "$mat.shinpercent"
    REFRACTI = "$mat.refracti"
    COLOR_DIFFUSE = "$clr.diffuse"
    COLOR_AMBIENT = "$clr.ambient"
    COLOR_SPECULAR = "$clr.specular"
    COLOR_EMISSIVE = "$clr.emissive"
    COLOR_TRANSPARENT = "$clr.transparent"
    COLOR_REFLECTIVE = "$clr.reflective"
    GLOBAL_BACKGROUND_IMAGE = "?bg.global"

    TEXTURE_BASE = "$tex.file"
    UVWSRC_BASE = "$tex.uvwsrc"
    TEXOP_BASE = "$tex.op"
    MAPPING_BASE = "$tex.mapping"
    TEXBLEND_BASE = "$tex.blend"
    MAPPINGMODE_U_BASE = "$tex.mapmodeu"
    MAPPINGMODE_V_BASE = "$tex.mapmodev"
    TEXMAP_AXIS_BASE = "$tex.mapaxis"
    UVTRANSFORM_BASE = "$tex.uvtrafo"
    TEXFLAGS_BASE = "$tex.flags"
  end

  module Process
    CALC_TANGENT_SPACE = 0x1
    JOIN_IDENTICAL_VERTICES = 0x2
    MAKE_LEFT_HANDED = 0x4
    TRIANGULATE = 0x8
    REMOVE_COMPONENT = 0x10
    GEN_NORMALS = 0x20
    GEN_SMOOTH_NORMALS = 0x40
    SPLIT_LARGE_MESHES = 0x80
    PRE_TRANSFORM_VERTICES = 0x100
    LIMIT_BONE_WEIGHTS = 0x200
    VALIDATE_DATA_STRUCTURE = 0x400
    IMPROVE_CACHE_LOCALITY = 0x800
    REMOVE_REDUNDANT_MATERIALS = 0x1000
    FIX_INFACING_NORMALS = 0x2000
    SORT_BY_P_TYPE = 0x8000
    FIND_DEGENERATES = 0x10000
    FIND_INVALID_DATA = 0x20000
    GEN_UV_COORDS = 0x40000
    TRANSFORM_UV_COORDS = 0x80000
    FIND_INSTANCES = 0x100000
    OPTIMIZE_MESHES = 0x200000
    OPTIMIZE_GRAPH = 0x400000
    FLIP_U_VS = 0x800000
    FLIP_WINDING_ORDER = 0x1000000
    SPLIT_BY_BONE_COUNT = 0x2000000
    DEBONE = 0x4000000
    GEN_ENTITY_MESHES = 0x100000
    OPTIMIZE_ANIMATIONS = 0x200000
    FIX_TEXTURE_PATHS = 0x200000
    EMBED_TEXTURES = 0x10000000

    CONVERT_TO_LEFT_HANDED =
      MAKE_LEFT_HANDED |
      FLIP_U_VS |
      FLIP_WINDING_ORDER |
      0

    module Preset
      TARGET_REALTIME_FAST =
        CALC_TANGENT_SPACE |
        GEN_NORMALS |
        JOIN_IDENTICAL_VERTICES |
        TRIANGULATE |
        GEN_UV_COORDS |
        SORT_BY_P_TYPE |
        0

      TARGET_REALTIME_QUALITY =
        CALC_TANGENT_SPACE |
        GEN_SMOOTH_NORMALS |
        JOIN_IDENTICAL_VERTICES |
        IMPROVE_CACHE_LOCALITY |
        LIMIT_BONE_WEIGHTS |
        REMOVE_REDUNDANT_MATERIALS |
        SPLIT_LARGE_MESHES |
        TRIANGULATE |
        GEN_UV_COORDS |
        SORT_BY_P_TYPE |
        FIND_DEGENERATES |
        FIND_INVALID_DATA |
        0

      TARGET_REALTIME_MAX_QUALITY =
        TARGET_REALTIME_QUALITY |
        FIND_INSTANCES |
        VALIDATE_DATA_STRUCTURE |
        OPTIMIZE_MESHES |
        0
    end
  end
end
