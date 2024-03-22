require "ffi"
require "zeitwerk"

# TODO: use zeitwerk to load these files
require_relative "constants"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "vector_3d" => "Vector3D"
loader.inflector.inflect "color_4d" => "Color4D"
loader.setup

module Assimp
  extend FFI::Library

  def self.load_lib(path = :libassimp)
    ffi_lib path

    attach_function :aiCreatePropertyStore, [], PropertyStore.by_ref
    attach_function :aiReleasePropertyStore, [PropertyStore.by_ref], :void
    attach_function :aiSetImportPropertyInteger, [PropertyStore.by_ref, :string, :int], :void

    attach_function :aiImportFile, [:string, :uint], Scene.by_ref, blocking: true
    attach_function :aiImportFileExWithProperties, [:string, :uint, :pointer, PropertyStore.by_ref], Scene.by_ref, blocking: true

    attach_function :aiGetMaterialTextureCount, [Material.by_ref, TextureType], :uint
    # TODO: remaining information
    attach_function :aiGetMaterialTexture, [Material.by_ref, TextureType, :uint, String.by_ref, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], Return
    attach_function :aiGetMaterialColor, [Material.by_ref, :string, :uint, :uint, Color4D.by_ref], Return
  end
end
