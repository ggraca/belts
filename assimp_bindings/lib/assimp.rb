require "ffi"
require "zeitwerk"

# TODO: use zeitwerk to load these files
require_relative "constants"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect "vector_3d" => "Vector3D"
loader.setup

module Assimp
  extend FFI::Library

  def self.load_lib(path = :libassimp)
    ffi_lib path

    attach_function :aiImportFile, [:string, :uint], Scene.by_ref, blocking: true
    # attach_function :aiGetMaterialProperty, [Material.by_ref, :string, :uint, :uint, MaterialProperty.by_ref], :uint
    attach_function :aiGetMaterialTextureCount, [Material.by_ref, TextureType], :uint

    # TODO: remaining information
    attach_function :aiGetMaterialTexture, [Material.by_ref, TextureType, :uint, String.by_ref, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], Return
  end
end
